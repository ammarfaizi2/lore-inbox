Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291399AbSBNKV6>; Thu, 14 Feb 2002 05:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291402AbSBNKVs>; Thu, 14 Feb 2002 05:21:48 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:46014 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S291399AbSBNKVi>;
	Thu, 14 Feb 2002 05:21:38 -0500
Date: Thu, 14 Feb 2002 11:21:31 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200202141021.LAA08331@harpo.it.uu.se>
To: ieure@qwest.net, linux-kernel@vger.kernel.org,
        linux-laptops@vger.kernel.org
Subject: Re: inspiron 8100 freezing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002 17:34:18 -0800, Ian Eure wrote:
>Hi there. My shiny new Dell Inspiron 8100 arrived in the mail today...
>...
>However, the system locks hard when I boot it up. The point where it dies 
>varies - it got as far as starting cron one time.
>
>Compiled a vanilla 2.4.17 & got the exact same thing. I'm not doing anything 
>exotic.
>
>ACPI is disabled, APM is configured thusly:

I bet you have CONFIG_SMP or CONFIG_X86_UP_APIC enabled. In that
case the hangs on the Inspiron are expected: it's BIOS is buggy.

A quick fix is to disable those two options. The proper fix is to
complain to Dell and tell them to fix their damn BIOS, then get a
2.4.18-pre or -rc kernel, and apply these patches

patch-boot-time-ioremap
patch-early-dmi-scan
patch-dmi-apic-fixups

from <http://www.csd.uu.se/~mikpe/linux/kernel-patches/2.4/>.

/Mikael

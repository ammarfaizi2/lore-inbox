Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270800AbTHOTZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270801AbTHOTZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:25:49 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:44296 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270800AbTHOTZr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:25:47 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Mikael Pettersson <mikpe@csd.uu.se>, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH][2.4.22-rc2] Disable APIC on reboot.
Date: Fri, 15 Aug 2003 21:22:10 +0200
User-Agent: KMail/1.5.3
Cc: marcelo@conectiva.com.br, fxkuehl@gmx.de, linux-kernel@vger.kernel.org,
       willy@w.ods.org
References: <E19mCuO-0003dI-00@tetrachloride> <16183.51974.508883.472043@gargle.gargle.HOWL> <16184.10173.412201.802953@gargle.gargle.HOWL>
In-Reply-To: <16184.10173.412201.802953@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308152121.44027.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 01:33, Mikael Pettersson wrote:

Hi Mikael,

> disable_local_APIC() now checks if detect_init_APIC() enabled the
> local APIC via the APIC_BASE MSR, and if so it now disables APIC_BASE.
> Previously we would leave APIC_BASE enabled, and that made some
> BIOSen unhappy.
> The SMP reboot code calls disable_local_APIC(). On SMP HW there is
> no change since detect_init_APIC() isn't called and APIC_BASE isn't
> enabled by us. An SMP kernel on UP HW behaves just like an UP_APIC
> kernel, so it disables APIC_BASE if we enabled it at boot.
> The UP_APIC disable-before-suspend code is simplified since the existing
> code to disable APIC_BASE is moved into disable_local_APIC().
> (Felix Kühling originally reported the BIOS reboot problem. This is a
> fixed-up version of his preliminary patch.)

please correct me if I say something really stupid now but shouldn't the APIC 
be disabled only during reboot time and enabled again at a new boot?

my experience with this patch is, after a reboot he APIC isn't enabled again 
until I power off my machine.

ciao, Marc


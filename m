Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVDLMos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVDLMos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVDLMoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:44:37 -0400
Received: from fmr17.intel.com ([134.134.136.16]:55467 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262353AbVDLMnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:43:13 -0400
Subject: Re: [PATCH 6/6]suspend/resume SMP support
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050412105115.GD17903@elf.ucw.cz>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
	 <20050412105115.GD17903@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1113309627.5155.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 12 Apr 2005 20:40:27 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 18:51, Pavel Machek wrote:
> > Using CPU hotplug to support suspend/resume SMP. Both S3 and S4 use
> > disable/enable_nonboot_cpus API. The S4 part is based on Pavel's
> > original S4 SMP patch.
> 
> I tested it on 2x PII(?) 550MHz system. Suspend went ok, resume loaded
> image from disk, but then I got
> 
> Thawing cpus ....
> Booting processor 1/0 eip 3000
> 
> ...and very funny effect on keyboard leds. They started to blink
> (panic-like), but with very wrong frequency. It looked like 2 cpus
> doing panic blinks at once...
Check if /sys/device/system/cpu/cpu1/online attribute works. If it
works, then it's other issue. I only tested the patches in two HT based
systems.

Thanks,
Shaohua


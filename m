Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVDMLZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVDMLZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVDMLZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:25:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45454 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261317AbVDMLZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:25:14 -0400
Date: Wed, 13 Apr 2005 13:24:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       dtor_core@ameritech.net, acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.11 acpi battery state readout as source of keyboard/touchpad troubles
Message-ID: <20050413112452.GA21023@elf.ucw.cz>
References: <424AF9C3.4000905@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424AF9C3.4000905@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In traceing the source of my sporadic synaptics touchpad troubles
> 
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
> 
> and keyboard troubles (sporadically lost key up/down events) on an Acer
> Aspire 1520 (x86_64, latest bios v1.09) I did enable the
> report_lost_ticks option which did spit out stuff like the following at
> regular intervals:
> 
> time.c: Lost 17 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 19 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 18 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> 
> This looked suspiciously like it happended when the the kde laptop
> applet polled the battery status. So I did terminate the applet.
> 
> The result was no more lost ticks, no lost keyboard events and no more
> lost touchpad sync.
> 
> To verify ACPI battery data as the source of trouble i did a simple
> 
> cat /proc/acpi/battery/BAT0/state
...

CONFIG_ACPI_DEBUG enabled by chance?
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

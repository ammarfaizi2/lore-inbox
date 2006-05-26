Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWEZWxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWEZWxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 18:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWEZWxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 18:53:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:50591 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751649AbWEZWxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 18:53:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=m+spVrXI8jjIuqUoiFHPtpasmwzby0OF69z/Z23+C4q1IzLyW/As/dh8x5ifyAIPd8r5DUvf7BM+tTjYoVx3ObVwM0nYIv2SOr+gPJ0ofFOK9ORMEMFhQEi/+G+4rTYn9y+VvSvim4/VLCRNva9+GNpDt3FVoJybkLh57DxVTYQ=
Message-ID: <1f1b08da0605261553v5e55ebdfpc790ebd5e5b0add8@mail.gmail.com>
Date: Fri, 26 May 2006 15:53:21 -0700
From: "john stultz" <johnstul@us.ibm.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: [-rt BUG] scheduling with irqs disabled: swapper
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
       "Thomas Gleixner" <tglx@linutronix.de>, mingo@redhat.com,
       lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 294384960fc69ce7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ingo, All,
	We had the following bug reported on bootup on one of our boxes (it
was a 4way I believe) running -rt22. So far it seems to be a one-off
but I figured I'd post it to see if anyone had a clue.

thanks
-john

...
usbmon: debugfs is not available
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
BUG: scheduling with irqs disabled: swapper/0x00010002/0
caller is rt_lock_slowlock+0xd2/0x139
 [<c030fb85>] schedule+0x60/0xd0 (8)
 [<c0310787>] rt_lock_slowlock+0xd2/0x139 (12)
 [<c0310e2d>] __lock_text_start+0x1d/0x1e (72)
 [<c022a57f>] i8042_interrupt+0x2c/0x1f0 (4)
 [<c013edb1>] misrouted_irq+0x85/0x118 (36)
 [<c013ef08>] note_interrupt+0x43/0x9f (36)
 [<c013e395>] __do_IRQ+0xc2/0xf9 (16)

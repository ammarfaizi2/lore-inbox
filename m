Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265340AbUBFQUL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 11:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUBFQUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 11:20:11 -0500
Received: from tristate.vision.ee ([194.204.30.144]:53418 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265340AbUBFQUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 11:20:07 -0500
Message-ID: <4023BEA8.5060306@vision.ee>
Date: Fri, 06 Feb 2004 18:19:52 +0200
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: irq 7: nobody cared! (intel8x0 sound / 2.6.2-rc3-mm1)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this when tried to run mplayer (mplayer played something audible for 
1 sec and then stalled):

irq 7: nobody cared!
Call Trace:
 [<c010c0f4>] __report_bad_irq+0x24/0x80
 [<c010c1d1>] note_interrupt+0x61/0x90
 [<c010c46d>] do_IRQ+0x10d/0x120
 [<c0279e1c>] common_interrupt+0x18/0x20
 [<c010c093>] handle_IRQ_event+0x23/0x60
 [<c010c3e3>] do_IRQ+0x83/0x120
 [<c0279e1c>] common_interrupt+0x18/0x20

handlers:
[<f99a1720>] (snd_intel8x0_interrupt+0x0/0x1e0 [snd_intel8x0])
Disabling IRQ #7

sound module in use is intel8x0 as seen above. Chip itself is nforce2
integrated audio.

I know there were problems earlier with this chip and new ALSA,
but thought maybe this is helpful. The kernel is booted with pci=noacpi
due to recent problems with nforce2 mb's using -mm series kernels.

It worked flawlessly in 2.6.1-rc1-mm1.

Lenar

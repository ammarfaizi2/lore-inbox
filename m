Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264708AbTE1MmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTE1MmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:42:08 -0400
Received: from [65.244.37.61] ([65.244.37.61]:3882 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S264708AbTE1MmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:42:00 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A92021C90DC@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: Stian Jordet <liste@jordet.nu>, viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Re: ALSA problems: sound lockup, modules, 2.5.70
Date: Wed, 28 May 2003 08:55:09 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Stian Jordet [mailto:liste@jordet.nu]
>
> tir, 27.05.2003 kl. 20.51 skrev viro@parcelfarce.linux.theplanet.co.uk:
>> 	Argh.  Missing initialization in char_dev.c - it's definitely
>> responsible for crap on unload.  Load side appears to be something >else,
>> though...
>
> This did not fix my problem. When I unload one ALSA-modules after the
> other, the system hangs when I come to the "snd" module. No oops or
> panic, it just freezes. Other than that, ALSA works fine for me, just
> frustrating when I reboot.
>
> Best regards,
> Stian

For what it's worth, maybe as a point to start to look for differences...

I am running 2.5.70-mm1, with snd-intel8x0 module.  Also SMP on Xeon P4
(2up), Intel chipset.  I am not having any problems with unloading snd.

So maybe the difference is between -mm1 and (IIRC) -bk1.

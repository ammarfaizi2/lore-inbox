Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132821AbRDPBI1>; Sun, 15 Apr 2001 21:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132820AbRDPBIR>; Sun, 15 Apr 2001 21:08:17 -0400
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:2944 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S132822AbRDPBII>; Sun, 15 Apr 2001 21:08:08 -0400
Date: Sun, 15 Apr 2001 21:08:07 -0400 (EDT)
From: Arthur Pedyczak <arthur-p@home.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: loop problems continue in 2.4.3
In-Reply-To: <3AD7EE80.5AADA578@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104152058210.1129-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Jeff Garzik wrote:

> Can you try 2.4.4-pre3?
> ftp://ftp.us.kernel.org/pub/linux/kernel/testing/
>
I am testing loop behaviour in 2.4.3 and 3.4.4p3. I have noticed something
disturbing:

I can mount the same file on the same mountpoint more than once. If I
mount a file twice (same file on the same mount point)
both mounts (identical) show when I do df or cat /proc/mounts. If I issue
unmount (once), both mounts disappear from df output, but one of them
remains in /proc/mounts. If I issue umount again, the second mount
disappers from cat /proc/mounts output, but the module 'loop' shows as
busy and cannot be removed even though there are no more loop mounts.
lsmod shows loop being used by 1 process.
If I repeat this whole procedure again, loop will be used by 2 processess
in the end. I guess something is wrong here.
This experiment has been done under 2.4.4pre3. I will try the same under
2.4.3.

cheers,
Arthur


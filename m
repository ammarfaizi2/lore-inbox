Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUDCWjz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 17:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUDCWjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 17:39:55 -0500
Received: from elma.elma.fi ([192.89.233.77]:50073 "EHLO elma.elma.fi")
	by vger.kernel.org with ESMTP id S262008AbUDCWjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 17:39:53 -0500
Date: Sun, 4 Apr 2004 01:39:50 +0300 (EETDST)
From: Antti Lankila <alankila@elma.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.[45]-.*: weird behaviour
Message-ID: <Pine.A41.4.58.0404040109160.42820@tokka.elma.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd like to say I'm seeing this too! At my work box I have a mouse in both
PS/2 and USB port, and keyboard in PS/2. When I put on some IDE load, the
kernel seems to stop listening to either or both of the mice, seeming at
random. It appears that the PS/2 mouse of the two is more reliable, though,
as it usually sees only stalls of about 5-6 seconds while the USB mouse can
be dead for 20 seconds or so. As a workaround I actually swap mice when the
other one stops working, though fairly often both are dead, so I'm left
frustrated waiting for the pointer to move.

The weird bit is, the machine is usually idle, it's not swapping, all X apps
work normally, they listen to keyboard input, etc. It's just that the bloody
mice aren't working! I have done cat /dev/psaux during these mouse stalls to
find that there is no characters output from the mouse/mice which currently
have "stalled", so the issue has to be in kernel. And I repeat, even when
both of them are dead, keyboard input still lands in the current active
window just fine, seemingly at no delay. There does not seem to be any
problem with the keyboard.

I have also noticed that IDE performance has really gone down switching from
2.6.3 to 2.6.4, though I don't know what could be the issue. I copied some
24 GB of stuff a couple of days back and it took _30 minutes_ to complete,
bringing down the average IO down to some 13 MB/s, but the thing is, this
was over two 2-disk RAID1 arrays made of 3 disks where one of the disk was
used by both of the arrays. Clearly, I wouldn't expect stellar peformance,
but I've done similar copies in the past and I don't remember them ever
being this slow to complete, either. This was also when I got plenty of time
to experiment with the pointer weirdness, as the copy dragged on forever,
and the mouse was stalling most of the time. Ugh.

Don't have much else to add. Sorry that this comes out as so vague. Being a
work box I can't reboot it easily at will, and right now I'm remoting it
until Easter, so someone else seeing this sort of behaviour has to give
patches a try.

-- 
Antti

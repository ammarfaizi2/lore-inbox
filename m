Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316473AbSEUAqw>; Mon, 20 May 2002 20:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316475AbSEUAqv>; Mon, 20 May 2002 20:46:51 -0400
Received: from server0043.freedom2surf.net ([194.106.33.53]:11463 "EHLO
	server0043.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S316474AbSEUAqu>; Mon, 20 May 2002 20:46:50 -0400
Date: Tue, 21 May 2002 01:55:17 +0100
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: RFC - named loop devices...
Message-Id: <20020521015517.609d5516.spyro@armlinux.org>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I havent thought about this too much, but...

When /etc/mtab is a symlink to /proc/mounts the umount command will fail
to unmount loopback mounted filesystems properly.

I was wondering if a solution to this would be to introduce 'named'
loopback devices.

with named loop devices, umount will then know that mount was the
creator of a loopback device that it mounted, and can safely destroy it.

at present, mounting and unmounting disc images causes one to run out of
loopback devices rather rapidly.

If I were to knock up a patch to implement named loop devices, would it
stand a chance of being accepted?

also, how should this work? should the name be that of the creating
process or should it just be a field that the creator can fill in as it
pleases?

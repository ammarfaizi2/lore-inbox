Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289311AbSAVOIC>; Tue, 22 Jan 2002 09:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289312AbSAVOHo>; Tue, 22 Jan 2002 09:07:44 -0500
Received: from firewall.esrf.fr ([193.49.43.1]:42458 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S289311AbSAVOHj>;
	Tue, 22 Jan 2002 09:07:39 -0500
Date: Tue, 22 Jan 2002 15:07:03 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: umounting
Message-ID: <20020122150703.B13509@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,
I use firewire devices and implements it for users at work.

I had to do some test and noticed a "bizarre" behaviour ( not really sure it is
):
User 1 is comming, He plugs his disk, mounts it and copy several datas.
Once finished, He unplug it without umounting it (what is bad, but
that's not the point).
User 2 comes, plugs his disk, tries to mount it but he can't because
it's already mounted. Without unplugging his disk, he umounts the
removed disk and then he tries mounting his one.
If user 1 had an ext2 disk, when user 2 umounts the filesystem with his
disk plugged his filesystem got broken ( tested with ext2 and vfat).
If user 1 had a vfat disk, then user 2 can cleanly umount the disk
without breaking any filesystem.
That's it.
Not sure whether it is an ext2, vfat or filesystem issue, or maybe not a
(kernel?)issue at all.
        Sam

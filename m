Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTITSGO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 14:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTITSGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 14:06:14 -0400
Received: from pop.gmx.net ([213.165.64.20]:21643 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261923AbTITSGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 14:06:13 -0400
X-Authenticated: #934491
Subject: Re: 2.6.0-test5-mm3 VFAT File system problem
From: Benjamin Weber <shawk@gmx.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1064081224.6093.5.camel@athxp.bwlinux.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Sep 2003 20:07:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm this behavior. 

I checked my fstab entry. Was saying:

/dev/hda5               /mnt/windows/D  vfat            rw,user,umask=0
0 0

After changing it to
/dev/hda5               /mnt/windows/D  vfat           
rw,user,uid=1001,gid=100 0 0

I got it working again half of the time. Its strange. Sometimes I get
the message that only root can unmount it, even when I mounted it as
user. 

Something is a little whacky there.

--
Benjamin


> Upon moving from -mm2 to -mm3, my vfat filesystems did not
> automatically bount at bootup as per the fstab and could not be
> accessed by applications in Gnome ie. my mount point showed no
> subdirectories or files.
> 
> I could manually mount (not by mount /mnt/win_c but by the full mount
> -t vfat /dev/hda1 /mnt/win_c) and I could explore using ls in
> terminals but programs in Gnome could not open the filesystem.
> 
> Upon rebooting into -mm2 everything was fine again.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285540AbRLSWQl>; Wed, 19 Dec 2001 17:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285553AbRLSWQb>; Wed, 19 Dec 2001 17:16:31 -0500
Received: from dialin-145-254-129-209.arcor-ip.net ([145.254.129.209]:1284
	"EHLO dale.home") by vger.kernel.org with ESMTP id <S285540AbRLSWQS>;
	Wed, 19 Dec 2001 17:16:18 -0500
Date: Wed, 19 Dec 2001 23:15:37 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.17-rc2: VFS: Busy inodes after unmount. Self-destruct...
Message-ID: <20011219231537.A3655@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dec 19 23:01:24 steel automount[3628]: mount(nfs): mounted dale.home:/ on /net/dale 
Dec 19 23:05:38 steel automount[3624]: shutting down, path = /net 
Dec 19 23:05:38 steel automount[3624]: >> umount: /net/dale: device is busy 
Dec 19 23:05:38 steel automount[3624]: could not unmount /net/dale 
Dec 19 23:05:38 steel automount[3624]: >> umount: /net: device is busy 
Dec 19 23:06:51 steel kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day... 


no self-destruct, of course, but the first 5 seconds wasn't so wonderful :)
I had the automount 3.1.7 running.
Auto-mounted a nfs node, got in, tried unmount,
got 'busy', went out of the mounted directory,
tried to unmount master directory (and failed),
unmounted the nfs-mounted directory,
unmounted the automount master directory.

The question is just: is that bad?

-alex


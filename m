Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279467AbRKRMuh>; Sun, 18 Nov 2001 07:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279470AbRKRMu2>; Sun, 18 Nov 2001 07:50:28 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:8082 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S279467AbRKRMuM>; Sun, 18 Nov 2001 07:50:12 -0500
Date: Sun, 18 Nov 2001 13:50:07 +0100
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: /sbin/mount and /proc/mounts difference
Message-ID: <20011118135007.A787@Zenith.starcenter>
Mail-Followup-To: Linux-Kernel Development Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.15-pre6
X-Telephone: +32 486 460306
X-Requested: Beautiful, smart and Linux-lovin' girlfriend
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When running "mount" I see:
	~$ mount
	/dev/hda6 on / type reiserfs (rw)
	proc on /proc type proc (rw)
	/dev/hda1 on /boot type ext2 (rw)
	/dev/hda7 on /usr type reiserfs (rw,noatime,notail)
	/dev/hda8 on /home type reiserfs (rw,nosuid,nodev,noatime,notail)
	/dev/hda9 on /var type reiserfs (rw,noexec,nodev)
	/dev/hda10 on /tmp type reiserfs (rw,noexec,nosuid,nodev)

while /proc/mounts says
	~$ cat /proc/mounts
	/dev/root / reiserfs rw 0 0
	/proc /proc proc rw 0 0
	/dev/hda1 /boot ext2 rw 0 0
	/dev/hda7 /usr reiserfs rw,noatime 0 0
	/dev/hda8 /home reiserfs rw,noatime,nosuid,nodev 0 0
	/dev/hda9 /var reiserfs rw,nodev,noexec 0 0
	/dev/hda10 /tmp reiserfs rw,nosuid,nodev,noexec 0 0

As you can see the notail-option of reiserfs isn't listed on /proc/mounts,
but it is on "mount".

Does this have any particular reason?

Wkr,
	Sven Vermeulen

-- 
Unix, MS-DOS and Windows NT (also known as the Good, the Bad and the
Ugly). ~(Matt Welsh)

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314951AbSDVXhA>; Mon, 22 Apr 2002 19:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314956AbSDVXg7>; Mon, 22 Apr 2002 19:36:59 -0400
Received: from dyn-213-36-84-123.ppp.tiscali.fr ([213.36.84.123]:32262 "HELO
	fjord.alezan.org") by vger.kernel.org with SMTP id <S314951AbSDVXg5>;
	Mon, 22 Apr 2002 19:36:57 -0400
Date: Tue, 23 Apr 2002 01:36:15 +0200
From: Profeta Mickael <mike@alezan.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre7, can not umount a partition
Message-Id: <20020423013615.4afd8062.mike@alezan.org>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

	I am running linux on Athlon CPU with VIA  VT82C686 ide controller.

	I try to upgrade to kernel-2.4.19-pre7 and I notice a trouble when I try
to unmount a partition: I wrote a cron job to make a backup of my honme
directory to a second harddrive using rsync. The data are on /dev/hda5and
are backuped on /dev/hdc2	The /dev/hdc2 partition is mounted in the
beginning of the script, and unmounted at the end of the rsync backup.	All my
partition are in reiserfs, except / in ext2.

	With kernel 2.4.19-pre7 or -pre6 the system can not umount the /dev/hdc2
partiton at the end of the script. The umount process hangs and the load
of the computer reach 2.0 whereas nothing else running. I can not reboot
properly (the system can not kill task and so does not reboot) If Itry
Sysrq, it manages to remount ro all partition except /dev/hdc2

	This does not happens in kernel 2.4.17-pre7.

	I have no Oops or message in the logs... But if I can do something to
test further the problem do not hesitate to ask me more information.

	I am running Debian sid with rsync version 2.5.6cvs  protocol version 26
	reiserfssprogs  3.x.1b-1 (I checked /dev/hdc2 has no reiserfs
inconsistency)	mount 2.11n-2

Please CC: as I am not subscribed to the list

	Mickael
	
-- 
-- 
Unix IS user-friendly. It just chooses its friends carefully

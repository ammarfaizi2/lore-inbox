Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265760AbUFYMTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265760AbUFYMTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUFYMTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:19:37 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:37108 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265760AbUFYMSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:18:32 -0400
Message-ID: <40DC180A.40204@comcast.net>
Date: Fri, 25 Jun 2004 08:18:18 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Christoph Hellwig <hch@infradead.org>,
       Helge Hafting <helge.hafting@hist.no>,
       John Richard Moser <nigelenki@comcast.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net> <40DBED77.6090704@hist.no>	 <40DC0CE0.6040509@comcast.net> <20040625114105.GA28892@infradead.org>	 <40DC1192.7030006@comcast.net>	 <1088165028.16286.59.camel@imp.csi.cam.ac.uk>	 <40DC1513.2070706@comcast.net> <1088165426.16286.67.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1088165426.16286.67.camel@imp.csi.cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------010803050506020205050200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010803050506020205050200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Anton Altaparmakov wrote:
> On Fri, 2004-06-25 at 13:05, David van Hoose wrote:
> 
>>All ext3 partitions are labeled as ext3. It still panics.
> 
> 
> Could you show your /etc/fstab?  (Only the root fs entry is of
> interest.)
> 
> And the output of: tune2fs -l /dev/hda1 | grep -i journal
> 
> You need to replace /dev/hda1 with your actual boot device...
> 
> Best regards,
> 
> 	Anton

[root@bahamut root]# /sbin/tune2fs -l /dev/sda2 | grep -i journal
Filesystem features:      has_journal filetype needs_recovery sparse_super
Journal inode:            8
Journal backup:           inode blocks

fstab is attached.
I have separate partitions for / and /boot, however, the outputs are all 
the same.

Regards,
David

--------------010803050506020205050200
Content-Type: text/plain;
 name="fstab"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fstab"

/dev/sda2		/                       ext3    defaults        1 1
/dev/sda1		/boot                   ext3    defaults        1 2
/dev/sda5               swap                    swap    defaults        0 0
/dev/sda6		/home			ext3	defaults	1 3
/dev/sda7		/mnt/data		auto	sync,uid=root,gid=shared,umask=007 1 3
/dev/sda8		/mnt/mp3s		auto	sync,uid=root,gid=shared,umask=007 1 3
/dev/hda1		/mnt/backup		ext3    defaults        1 4
none                    /dev/pts                devpts  gid=5,mode=620  0 0
none                    /proc                   proc    defaults        0 0
none                    /dev/shm                tmpfs   defaults        0 0
/dev/cdrom              /mnt/cdrom              udf,iso9660 noauto,owner,kudzu,ro 0 0
/dev/fd0                /mnt/floppy             auto    noauto,owner,kudzu 0 0

--------------010803050506020205050200--

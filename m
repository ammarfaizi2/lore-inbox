Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264249AbTIIR7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbTIIR7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:59:16 -0400
Received: from n105.priced2go.net ([208.179.93.105]:43933 "EHLO
	ying.yingternet.com") by vger.kernel.org with ESMTP id S264249AbTIIR7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:59:15 -0400
Message-ID: <3F5E14FC.5090001@yingternet.com>
Date: Tue, 09 Sep 2003 10:59:24 -0700
From: Ying-Hung Chen <ying@yingternet.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: wierd raid 1 problem
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I have recently encounter a weird raid 1 problem on my system. Here is 
my setup:

i have two ide harddisk on a promise ide control card (PDC20262)

and here is my /etc/raidtab file

raiddev       /dev/md0
raid-level    1
chunk-size    64k
persistent-superblock 1

nr-raid-disks 2
     device    /dev/hdd1
     raid-disk 0
     device    /dev/hdb1
     raid-disk 1


the file system is XFS. everything works most of time except from time 
to time, files seem to get corrupted. I test the integrity by running 
rpm --checks *.rpm continuously to verify the signature of the file.

the corrupted files seem to 'recover' itself if i leave the machine 
alone for a while or umount and mount back the filesystem.

does anyone have this type of temperory file corruption problem? I 
tested it against 2.4.2x kernel including the last vanilla 2.4.22 + xfs 
patches, they all seem to have the same problem

Thanks,

-Ying


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTJ0WM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 17:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbTJ0WMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 17:12:25 -0500
Received: from ns2.ploiesti.rdsnet.ro ([213.157.173.133]:3220 "HELO
	webhosting.ploiesti.rdsnet.ro") by vger.kernel.org with SMTP
	id S263639AbTJ0WKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 17:10:52 -0500
Message-ID: <3F9D97E8.4040209@smartpost.ro>
Date: Tue, 28 Oct 2003 00:10:48 +0200
From: Mircea Ciocan <mircea@smartpost.ro>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: ro, en-us, en
MIME-Version: 1.0
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Strange very large disk partitions behaviour !!!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi kernel developers,

    I have a RAID  disk enclosure  that contains 16 IDE disks that is 
seen via its SCSI interface as a very large disk sliced in 3 QUASI 
IDENTICAL partitions, here is the fdisk information:

[root@nfs00 root]# fdisk /dev/sdb

Disk /dev/sdb: 2199.0 GB, 2199014866944 bytes
64 heads, 32 sectors/track, 2097144 cylinders
Units = cylinders of 2048 * 512 = 1048576 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdb1             1        699048 715825136   83  Linux
/dev/sdb2        699049   1398096 715825152   83  Linux
/dev/sdb3       1398097   2097144 715825152   83  Linux

So I formated each partition ext3 ( that went ok) and monted the beasts:

[root@nfs00 root]# df
/dev/scsi/host2/bus0/target0/lun0/part1
                     1008G   33M  957G   1% /mnt/p1
/dev/scsi/host2/bus0/target0/lun0/part2
                      672G   33M  638G   1% /mnt/p2
/dev/scsi/host2/bus0/target0/lun0/part3
                      672G   33M  638G   1% /mnt/p3


[root@nfs00 root]# df -k
/dev/scsi/host2/bus0/target0/lun0/part1
                     1056887972     32828 1003168364   1% /mnt/p1
/dev/scsi/host2/bus0/target0/lun0/part2
                     704592112     32828 668768028   1% /mnt/p2
/dev/scsi/host2/bus0/target0/lun0/part3
                     704592112     32828 668768028   1% /mnt/p3

    Now I'm really confused, the  LARGER partitons  are showed  SMALLER 
then the smaller partitions and why that enormous difference, what I'm 
doing wrong, I've fsck each partiton and all seem to be OK, I'm afraid 
of an integer overflow or such thing that can blew the whole storage or 
I'm too tired and overlooking something.
    Please help me while I'm still having some hair left TIA.


    Best regards,

    Mircea Ciocan


    P.S. Kernel is 2.4.21, glibc-2.3.2, any othe info on request.










Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVGLQix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVGLQix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVGLQgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:36:13 -0400
Received: from web52013.mail.yahoo.com ([206.190.48.96]:58972 "HELO
	web52013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261582AbVGLQfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:35:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=rONZXgf/o0Gtj6YiRIzCp6mmsI+uTgaOzL2Gq2AW97OCHjvDL/D9mjlUrfetxM35xnfS5QJbLF8ES4nVAL7ZCCfz6d4XpjaiiU6wSeaWdtjuEszjjqXLLsD2ptEB42CyA46Jp7WGLIwe1jTDVhmWuhudaoq+Jbs4sE9Hasqmz6g=  ;
Message-ID: <20050712163514.42322.qmail@web52013.mail.yahoo.com>
Date: Tue, 12 Jul 2005 09:35:14 -0700 (PDT)
From: Konstantin Kudin <konstantin_kudin@yahoo.com>
Subject: fdisk: What do plus signs after "Blocks" mean?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi there,

 Fdisk on my machine displays the output shown below. Many partitions
have pluses after "Blocks". The issue is that during installation on
the existing linux setup WinXP screwed up the partition table, and
these pluses were very difficult to recreate. Basically, if I remove
hda9, and then try to recreate it in fdisk, it loses the plus sign and
does not look as before. Also, sometimes fdisk creates a partition with
"+", and sometimes it does not.

 Since I did not want to take any chances, I used Knoppix to read a
similar partition table from /dev/hdb using "sfdisk -dx", and then
copied it to /dev/hda by using "sfdisk -fx". If I do not force sfdisk
by using "-f", it complains that there are some inconsistencies.

 Can anyone enlighten me what the pluses mean? Also, if a partition
loses pluses after "Blocks", would that destroy a RAID array?

 Thanks!
 Konstantin



#################
fdisk -l /dev/hda

Disk /dev/hda: 160.0 GB, 160041885696 bytes
255 heads, 63 sectors/track, 19457 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1   *           1           3       24066    7  HPFS/NTFS
/dev/hda2               4       19457   156264255    5  Extended
/dev/hda5               4         264     2096451   82  Linux swap
/dev/hda6             265        2176    15358108+  fd  Linux raid
autodetect
/dev/hda7            2177        4088    15358108+   7  HPFS/NTFS
/dev/hda8            4089        7912    30716248+  fd  Linux raid
autodetect
/dev/hda9            7913       19457    92735212+  fd  Linux raid
autodetect



		
____________________________________________________
Sell on Yahoo! Auctions – no fees. Bid on great items.  
http://auctions.yahoo.com/

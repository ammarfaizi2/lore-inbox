Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTBFJ3E>; Thu, 6 Feb 2003 04:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbTBFJ3E>; Thu, 6 Feb 2003 04:29:04 -0500
Received: from geo-resources.xs4all.nl ([213.84.3.109]:29596 "EHLO
	geo-resources.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265815AbTBFJ3D>; Thu, 6 Feb 2003 04:29:03 -0500
Message-ID: <3E423B4A.2020900@xs4all.nl>
Date: Thu, 06 Feb 2003 11:39:06 +0100
From: Auke Kok <sofar@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HPT370 hangs on partition check
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: sofar@xs4all.nl (not subscribed - on dialup)
V:2.4.20

I've got a HPT370 on a adaptec 1200a PCI card that I use as add-on raid 
controller, which hangs the boot process during the 'partition check' in 
case there is only one drive (set to cable select) and connected to the 
secondary ide channel of the HPT370.

The system actually hangs on "ide2" which is the primary ide channel of 
the HPT370, and is empty in my system, during the partition check, so 
dmesg already displays all availble drives and channels in order.

Putting the drive to 'master' actually resolves the problem.

The fact that the ide system is probing ide2 for partitions while 
there's no drives attached to it make me wonder if the ide system didn't 
got told that there was no drive attached to it by the hpt driver. I can 
only wonder about why the whole system hasn't got the problem when the 
drive is set to 'master'.

summarized:
  ide0: hda: HD hdb:CDRW
  ide1: unused, disabled in onboard mobo
  ide2: unused
  ide3: hdg: HD(cable select, therefore master) hdh:empty

Auke Kok
CC: sofar@xs4all.nl (not subscribed - on dialup)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbSJNSd4>; Mon, 14 Oct 2002 14:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262084AbSJNSd4>; Mon, 14 Oct 2002 14:33:56 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:13049 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S262083AbSJNSdz>; Mon, 14 Oct 2002 14:33:55 -0400
Message-ID: <3DAB1007.6040400@mvista.com>
Date: Mon, 14 Oct 2002 11:42:15 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml,

http://www.sourceforge.net/project/showfiles.php?group_id=64580

I am announcing a sourceforge project for developing support in Linux 
kernel for Advanced TCA (PICMG 3.0) architecture.  Advanced TCA is a 
technology where boards exist in a chassis and can either be processor 
nodes or storage nodes.  All boards in the chassis are connected by 
FibreChannel and Ethernet.  The blades can be hot added or hot removed 
while the Linux processor nodes are active, meaning, that the SCSI 
subsystem must add devices on insertion request and remove devices on 
ejection requests.  Further the typical /dev/sda naming of devices is 
not appropriate since device nodes can change depending on the insertion 
order of disks.

These patches are for Linux 2.4.19 and work with the Qlogic 2300 
FibreChannel driver and at this point mostly support hotswap of the disk 
subsystem.

The patches consist of a SCSI hotswap patch for 2.4 kernel and QLA 2300 
support.

The patches also consist of a GA Mapper library which maps fibrechannel 
WWNs to devices in devfs filesystems such as /dev/scsi/chassis/slot/disc.

The sourceforge project also contains a userland library for each patch 
and userland applications such that these operations can be scripted.

Advanced TCA uses IPMI, so this project will use the IPMI driver being 
developed by Corey Minyard.

To be posted are userland or kernel hotswap managers.  I've not decided 
how to do this yet, so I'll post the bits when they are done.

I welcome comments questions or code to be added to the sourceforge project.

Thanks,
-steve


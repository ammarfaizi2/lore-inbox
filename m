Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271949AbRH2MW0>; Wed, 29 Aug 2001 08:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271956AbRH2MWR>; Wed, 29 Aug 2001 08:22:17 -0400
Received: from [195.66.192.167] ([195.66.192.167]:13318 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271949AbRH2MWM>; Wed, 29 Aug 2001 08:22:12 -0400
Date: Wed, 29 Aug 2001 15:14:17 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <6410958637.20010829151417@port.imtp.ilyichevsk.odessa.ua>
To: Andreas Dilger <adilger@turbolabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: fsck root fs: fsck, devfs, /proc/mounts miscooperate.
In-Reply-To: <20010829021304.D24270@turbolinux.com>
In-Reply-To: <22075604.20010829095413@port.imtp.ilyichevsk.odessa.ua>
 <20010829021304.D24270@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andreas,

Wednesday, August 29, 2001, 11:13:04 AM, you wrote:
>> # fsck /dev/scsi/host0/bus0/target1/lun0/part1
>> Parallelizing fsck version 1.15 (18-Jul-1999)
>> e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
>> /dev/scsi/host0/bus0/target1/lun0/part1 is mounted.
>> 
>> WARNING!!!  Running e2fsck on a mounted filesystem may cause
>> SEVERE filesystem damage...

AD> Get a new version of e2fsprogs (at http://sf.net/projects/e2fsprogs).
AD> The detection of mounted root filesystems has changed in recent releases,
AD> so it _should_ be fixed - let us know if it is not.

Installed e2fsprogs 1.23. It does not print warning now on
"fsck /dev/scsi/host0/bus0/target1/lun0/part1"
However, it still cannot fs check root fs when given "fsck /" which I
really need in my init script. Now the only way to do root fs check
for me is to parse /proc/mounts and extract mount point for / via sed
(I have never used sed yet...).

# fsck /
Parallelizing fsck version 1.15 (18-Jul-1999)
e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
/sbin/e2fsck: Is a directory while trying to open /

The superblock could not be read or does not describe a correct ext2
filesystem...

Best regards,
VDA
--
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/



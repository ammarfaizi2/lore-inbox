Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272664AbRHaLBT>; Fri, 31 Aug 2001 07:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272663AbRHaLBJ>; Fri, 31 Aug 2001 07:01:09 -0400
Received: from [195.66.192.167] ([195.66.192.167]:15887 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272664AbRHaLA6>; Fri, 31 Aug 2001 07:00:58 -0400
Date: Fri, 31 Aug 2001 13:58:42 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <985431419.20010831135842@port.imtp.ilyichevsk.odessa.ua>
To: Theodore Tso <tytso@mit.edu>
CC: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re[4]: fsck root fs: fsck, devfs, /proc/mounts miscooperate.
In-Reply-To: <20010830153910.C3114@thunk.org>
In-Reply-To: <22075604.20010829095413@port.imtp.ilyichevsk.odessa.ua>
 <20010829021304.D24270@turbolinux.com>
 <6410958637.20010829151417@port.imtp.ilyichevsk.odessa.ua>
 <20010830153910.C3114@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ted,

Thursday, August 30, 2001, 10:39:10 PM, you wrote:
>> # fsck /
>> Parallelizing fsck version 1.15 (18-Jul-1999)
>> e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
>> /sbin/e2fsck: Is a directory while trying to open /

TT> Umm... it works for me.  (No, I don't use devfs, but I do test
TT> e2fsprogs to make sure they do some sane vs. devfs by using UML...)
...
TT> What does your /etc/mtab file show for an entry for the root
TT> filesystem when you're trying to make it work?  Fsck does require that
TT> /etc/mtab is sane, and I'm guessing that you're missing an entry in
TT> /etc/mtab for /. 

My /etc/mtab is symlinked to /proc/mounts and have these entries:
/dev/scsi/host0/bus0/target1/lun0/part1 / ext2 ro 0 0
/dev/sda2 /.share ext2 rw 0 0
...

Also fsck does not work for my second mountpoint if specified
as a relative path:

pegasus:/#fsck .share    <--- relative path
Parallelizing fsck version 1.23 (15-Aug-2001)
No devices specified to be checked!
pegasus:/#fsck /.share    <--- absolute path
Parallelizing fsck version 1.23 (15-Aug-2001)
e2fsck 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
/dev/sda2 is mounted.
WARNING! Running e2fsck on a mounted filesystem...

Looks like running "fsck <mountpoint>" is uncommon
and isn't tested much.
--
Best regards,
VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/



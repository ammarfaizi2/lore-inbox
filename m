Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289366AbSAVTXK>; Tue, 22 Jan 2002 14:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289365AbSAVTXA>; Tue, 22 Jan 2002 14:23:00 -0500
Received: from [24.64.71.161] ([24.64.71.161]:6639 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S289364AbSAVTWx>;
	Tue, 22 Jan 2002 14:22:53 -0500
Date: Tue, 22 Jan 2002 12:22:39 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: something about ext2 file system
Message-ID: <20020122122239.A4014@lynx.turbolabs.com>
Mail-Followup-To: Michael Zhu <mylinuxk@yahoo.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020122140613.51122.qmail@web14905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020122140613.51122.qmail@web14905.mail.yahoo.com>; from mylinuxk@yahoo.ca on Tue, Jan 22, 2002 at 09:06:13AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 22, 2002  09:06 -0500, Michael Zhu wrote:
> 1.How the directory and file name information are
> stored on the disk? I mean is there a range of blocks
> set at disk format or intialize time for this kind of
> information?

Like most Unix filesystems, directories are just a special form of
a file, so they are stored in data blocks.  See the structure
ext2_dir_entry_2 in linux/include/ext2_fs.h for more info on the
exact layout on disk.

> 2.I know in ext2 the whole disk is made up of the boot
> block and some block groups. Each block groups
> contains super block,group descriptors,data block
> bitmap,inode bitmap,inode table and data blocks. The
> directory and file name information are stored in
> which part? In the data blocks?

As above - directories are
> 
> 3.Are file names and other metadata put into the same
> range of blocks?

No.  Only the filename and inode number are in the directory, along
with some data about the length of the directory entry.

> 4.Where can I find some detail information about ext2
> fiel system?

There are several papers which describe the structure of ext2
available on the internet.  One is probably available from
http://e2fsprogs.sourceforge.net/

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


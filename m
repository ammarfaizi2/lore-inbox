Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSJ3D52>; Tue, 29 Oct 2002 22:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263377AbSJ3D52>; Tue, 29 Oct 2002 22:57:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51975 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263280AbSJ3D50>;
	Tue, 29 Oct 2002 22:57:26 -0500
Message-ID: <3DBF5A08.9090407@pobox.com>
Date: Tue, 29 Oct 2002 23:03:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
CC: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF4DBA.8060005@rackable.com> <3DBF5756.2010702@lougher.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher wrote:

> Samuel Flory wrote:
>
>> Phillip Lougher wrote:
>>
>>> Hi,
>>>
>>> First release of squashfs.  Squashfs is a highly compressed 
>>> read-only filesystem for Linux (kernel 2.4.x).  It uses zlib 
>>> compression to compress both files, inodes and directories.  Inodes 
>>> in the system are very small and all blocks are packed to minimise 
>>> data overhead. Block sizes greater than 4K are supported up to a 
>>> maximum of 32K.
>>>
>>> Squashfs is intended for general read-only filesystem use, for 
>>> archival use, and in embedded systems where low overhead is needed.
>>>
>>> Squashfs is available from http://squashfs.sourceforge.net.
>>>
>>> The patch file is currently against 2.4.19.  There is further info 
>>> on the filesystem design etc. in the README.
>>>
>>> I'l be interested in getting any feedback, advice etc. on it.
>>>
>>
>>  What are the advantages of squashfs vs cramfs?
>>
>>
>>
>
> Cramfs was the inspiration for squashfs.  Squashfs basically gives 
> better compression, bigger files/filesystem support, and more inode 
> information.
>
> 1. Blocks upto 32K are supported - data is compressed in units of 32K 
> which achieves better compression ratios than compressing in 4K 
> blocks.  Generally using bigger than 4K blocks are a bad idea, because 
> the VFS calls the filesystem in 4K pages.  Squashfs explictly pushes 
> the extra block data into the page cache.

I'm curious if you looked at ntfs-tng's code before implementing this. 
 It's pretty darned optimal...

> 2. Squashfs compresses inode and directory information in addition to 
> file data.  Inodes/directories generally compress down to 50%, or say 
> on average 8 bytes or less per inode.

squashfs or mksquashfs?

A r/w compressed filesystem would be darned useful too :)

    Jeff





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbSJ3XzJ>; Wed, 30 Oct 2002 18:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264973AbSJ3XzJ>; Wed, 30 Oct 2002 18:55:09 -0500
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:50388 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id <S264969AbSJ3XzF>; Wed, 30 Oct 2002 18:55:05 -0500
Message-ID: <3DC0719A.30101@lougher.demon.co.uk>
Date: Wed, 30 Oct 2002 23:56:10 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020604
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF4DBA.8060005@rackable.com> <3DBF5756.2010702@lougher.demon.co.uk> <3DBF5A08.9090407@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
 > Phillip Lougher wrote:

 >
 >> 2. Squashfs compresses inode and directory information in addition
 >> to file data.  Inodes/directories generally compress down to 50%, or
 >> say on average 8 bytes or less per inode.
 >
 >
 > squashfs or mksquashfs?

mksquashfs...

 >
 > A r/w compressed filesystem would be darned useful too :)
 >
 > Jeff
 >

A r/w compressed filesystem may be my next project...  As a couple of
people have mentioned there are compressed r/w filesystems already
out there.

As you'll know, there are always tradeoffs with filesystem design,
it is very difficult to get as good compression with a r/w fs
than with a read only filesystem.  I wanted to get maximum
compression, and quite a few of the techniques I use rely on
its read-only nature.

An append only (i.e. files can be added, but not modified), fs might
be a useful compromise.  With compressed metadata, any modification
of files will inevitably achive different compression ratios, and so
modification of metadata/files in place is not an option.  Appending
modified metadata/data brings you to log-structured (journalling)
filesystems and compaction (log cleaning) requirements with consequent
loss of compression.

Phillip


 >
 >
 >
 >




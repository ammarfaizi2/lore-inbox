Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbSJaEHJ>; Wed, 30 Oct 2002 23:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265182AbSJaEHJ>; Wed, 30 Oct 2002 23:07:09 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:9745 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S265180AbSJaEHI>; Wed, 30 Oct 2002 23:07:08 -0500
Message-ID: <3DC0ACA9.2090807@lougher.demon.co.uk>
Date: Thu, 31 Oct 2002 04:08:09 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020604
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, plougher@acm.org
CC: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF4DBA.8060005@rackable.com> <3DBF5756.2010702@lougher.demon.co.uk> <20021030072838.A628@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Wed, Oct 30, 2002 at 03:51:50AM +0000, Phillip Lougher wrote:
>
>>File sizes upto 2^32 are supported.
 >
> Why limiting to 2GB? AFAIR you wanted to use a cramfs-like
> filesystem for backups. Are videos and large data bases not worth
> of backing up?
> 

Why are files limited to 4GB? (2^32). Simply because I never
thought anything bigger was needed :-)  Initially files were limited to
2^24 (like cramfs), but because of compressed metadata I thought I could
justify an extra 8 bits in the inode, in consideration of the
extra functionality.

Going from 32 bits to 40 bits say is a bigger jump - an extra
2 bytes per file inode (1 byte for the extra file size, and 1
byte because the file start block pointer must increase
by 1 byte as well).  Considering the fact I've tried to squeeze
every last byte out...

However, I could add the extra two bytes if people thought
it was worth it.

Alternatively,  squashfs uses different inodes per file type.  I could
add an extra "big file" type to deal with files bigger than 4GB.  This
would mean > 4GB files are supported, with only one extra byte per inode
for smaller files.  I'll think about it...

> It seems to be good work. So I really wait for Al Viros comments ;-)

Thanks!

Phillip

> Regards
> 
> Ingo Oeser



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbSJaFLo>; Thu, 31 Oct 2002 00:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264895AbSJaFLo>; Thu, 31 Oct 2002 00:11:44 -0500
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:5549 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id <S264733AbSJaFLo>; Thu, 31 Oct 2002 00:11:44 -0500
Message-ID: <3DC0BBC8.4080104@lougher.demon.co.uk>
Date: Thu, 31 Oct 2002 05:12:40 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020604
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: willy@debian.com
CC: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT:  Squashfs released (a highly compressed filesystem)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
 >Larry McVoy wrote:
 >> > A r/w compressed filesystem would be darned useful too :)
 >> > mmap(2) is, err, hard. Not impossible, it means the file system 
has >to
 >> support both compressed and uncompressed files, but it's interesting.
 >
 >Easier than you think, perhaps.  Depends how much compression you're
 >after, of course, but here's how Acorn did it in RISCiX (a 4.3BSD
 >derivative):
 >

Strange you should mention this... I used to work at Acorn with
the guy who did this (Mark Taunton). RISCiX was too early to be 4.3, I
think it was 4.1, but may have been 4.2, certainly no later, this was
1989.

 >Pages were 32k (an interesting feature of the MMU...), and the 
 >underlying filesystem was a fairly vanilla BSD FFS (probably 4k blocks
 >with 1k fragments; discs were around 50MB).  Each page was written at 
a >32k boundary, but compressed.  So there were holes in the file where 
 >other files could store their data.  Naturally you waste on average 
512 >bytes per 32k page, but I think they managed to get 80MB of unix 
distro >onto a 50MB disc this way, so it's nothing to be sneezed at.

They only needed to compress the fs on the R140 (an ARM 2 based
machine).  The better R260 had a bigger disk, and so didn't need the
compression. Interestingly, because of the slow disk I/O, compression
made the filesystem access faster.

I had an R140, and space was so tight in the filesystem, you had
to delete part of the distribution before you could even compile
a program!

Phillip


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131313AbRBMNI6>; Tue, 13 Feb 2001 08:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131347AbRBMNIs>; Tue, 13 Feb 2001 08:08:48 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:32273 "EHLO
	nt1.antefacto.com") by vger.kernel.org with ESMTP
	id <S131313AbRBMNIj>; Tue, 13 Feb 2001 08:08:39 -0500
Message-ID: <3A8931C1.4090601@AnteFacto.com>
Date: Tue, 13 Feb 2001 13:08:17 +0000
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: mas9483@ksu.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: gzipped executables
In-Reply-To: <20010213084031.8598.qmail@www1.nameplanet.com> <20010213130949.A472@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might consider UPX (http://upx.tsx.org)
Very cool. The beta version supports compressing the kernel
and "direct-to-memory" compression. I think it still
has the disadvantage of not sharing segments between many
instances of the same program. Is there any way of fixing
this? (probably would have to hack a bit with the loader?)

For a general solution I would look @ changing the filesystem
so that particular files (not just executables) can be compressed/
decompressed transparently. (I.E. for ext2 implement `chattr +c`).

Padraig.

Ingo Oeser wrote:

> On Tue, Feb 13, 2001 at 08:40:31AM -0000, ketil@froyn.com wrote:
> 
>> On Mon, 12 Feb 2001 23:09:39 -0600 (CST) Matt Stegman <mas9483@ksu.edu> wrote:
>> 
>>> Is there any kernel patch that would allow Linux to properly recognize,
>>> and execute gzipped executables?
>> 
>> Perhaps you could put it in the filesystem. Look at the
>> "chattr" manpage, which shows how this is meant to work with
>> ext2. It seems not to have been implemented yet. This way you
>> could also compress any files, not just executables.
> 
> 
> A nice way already implemented in 2.4.x is cramfs. Many embedded
> people (like me) use it to fill up their flash disks.
> 
> Look at linux/Documentation/filesystems/cramfs.txt for more info.
> 
> Regards
> 
> Ingo Oeser


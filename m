Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUG0SHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUG0SHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUG0SHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:07:08 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:30346 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266505AbUG0SDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:03:39 -0400
Message-ID: <410698FA.40400@namesys.com>
Date: Tue, 27 Jul 2004 11:03:38 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Rutt <rutt.4+news@osu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: clearing filesystem cache for I/O benchmarks
References: <87vfgeuyf5.fsf@osu.edu> <20040726002524.2ade65c3.akpm@osdl.org> <87pt6iq5u2.fsf@osu.edu> <20040726234005.597a94db.akpm@osdl.org> <4106013E.30408@namesys.com> <87vfg9nyqv.fsf@osu.edu>
In-Reply-To: <87vfg9nyqv.fsf@osu.edu>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Rutt wrote:

>Hans Reiser <reiser@namesys.com> writes:
>
>  
>
>>when benchmarking, please be careful that you don't end up
>>benchmarking umount/mount, or sync, or..... it can be remarkably hard
>>to avoid such mistakes.....
>>    
>>
>
>I agree, I've made some blunders like that in the past.  However for
>write tests, we are including fsync() time, once, at the end of a file
>write, since I feel it's unfair to trim that time.
>
fsync performance gives you different performance.  Better to write more 
stuff to flush the cache.

>  Not including
>fsync() time would only test the ability of the various parts of the
>I/O systems to do write buffering.  It's easy to do lots of write
>buffering, if you buy enough memory.  Forcing the disks to write is
>the only fair way to compare writes between I/O systems.
>  
>
It isn't fair.  fsync is a different code path, and may be less 
efficient.  Or more, depending on the fs.  reiser4 is currently not well 
optimized for fsync, maybe next year I will change that but not this 
week....

Benchmarking well is hard.....

Hans

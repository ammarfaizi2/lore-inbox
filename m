Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSH1AWG>; Tue, 27 Aug 2002 20:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318062AbSH1AWE>; Tue, 27 Aug 2002 20:22:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15376 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318009AbSH1AVv>; Tue, 27 Aug 2002 20:21:51 -0400
Message-ID: <3D6C189D.7080101@zytor.com>
Date: Tue, 27 Aug 2002 17:26:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is it possible to use 8K page size on a i386 pc?
References: <39B5C4829263D411AA93009027AE9EBB13299663@fmsmsx35.fm.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
> H. Peter Anvin wrote:
> 
>>Followup to:  <200208271914.g7RJEQE07821@devserv.devel.redhat.com>
>>By author:    Pete Zaitcev <zaitcev@redhat.com>
>>In newsgroup: linux.dev.kernel
>>
>>>You may run into trouble with something that calls mmap with
>>>a fixed address, with executables which have text sizes of
>>>odd number of small pages. I was told that these problems are
>>>fairly rare.
>>
>>Only 50% of all binaries are affected... that's fairly rare :)
> 
> The majority of x86 linux binaries run on ia64 with a 16K
> pagesize (admittedly with some not-so-pretty code to fudge
> mmap/munmap addresses ... but it is proof that you can reduce
> the problems to "fairly rare").
> 

It's proof that you can kluge around it.  Part of the issue is with the
handling of the code versus data segment, which means you have to treat
(part of) the code segment as data.

Changing the i386 port to use > 4K pages would have to go through
similar contortions.

	-hpa



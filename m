Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVLIVa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVLIVa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVLIVa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:30:26 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:4518 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932470AbVLIVaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:30:25 -0500
Date: Fri, 9 Dec 2005 21:30:21 +0000 (GMT)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Lee Revell <rlrevell@joe-job.com>
cc: Ken Moffat <zarniwhoop@ntlworld.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
In-Reply-To: <1134158342.18432.1.camel@mindpipe>
Message-ID: <Pine.LNX.4.63.0512092121080.23848@deepthought.mydomain>
References: <1134154208.14363.8.camel@mindpipe> 
 <Pine.LNX.4.63.0512091930440.19998@deepthought.mydomain>
 <1134158342.18432.1.camel@mindpipe>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-562600463-1134163821=:23848"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-562600463-1134163821=:23848
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 9 Dec 2005, Lee Revell wrote:

>
> $ file init/built-in.o
> init/built-in.o: ELF 64-bit LSB relocatable, AMD x86-64, version 1
> (SYSV), not stripped
>
>> From man gcc, i386 section:
>
> -m32
> -m64
>    Generate code for a 32-bit or 64-bit environment.  The 32-bit
>    environment sets int, long and pointer to 32
>    bits and generates code that runs on any i386 system.  The
>    64-bit environment sets int to 32 bits and long
>    and pointer to 64 bits and generates code for AMD's x86-64
>    architecture.
>
> Lee
>

  Yes, file shows your gcc does indeed do the right thing with -m64, and 
thank you, but I was already familiar with -m64 (to say nothing of 
passing LDEMULATION to userspace compilations [info binutils, if you 
need to know]).

  So, do you have some sort of religious objection to using 
CROSS_COMPILE= when building for a processor that doesn't match the 
userspace ?  And I repeat, messing with CFLAGS should NOT be necessary.

Ken
-- 
  das eine Mal als Tragödie, das andere Mal als Farce

---1463809536-562600463-1134163821=:23848--

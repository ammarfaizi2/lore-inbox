Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275268AbRJFP2N>; Sat, 6 Oct 2001 11:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRJFP2D>; Sat, 6 Oct 2001 11:28:03 -0400
Received: from [195.223.140.107] ([195.223.140.107]:17403 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275255AbRJFP17>;
	Sat, 6 Oct 2001 11:27:59 -0400
Date: Sat, 6 Oct 2001 17:28:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: OOM-Killer in 2.4.11pre4
Message-ID: <20011006172829.F724@athlon.random>
In-Reply-To: <E15plMj-0002eK-00@mrvdom01.schlund.de> <20011006162617.A724@athlon.random> <E15pt4D-0002N4-00@mrvdom02.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E15pt4D-0002N4-00@mrvdom02.schlund.de>; from linux-kernel@borntraeger.net on Sat, Oct 06, 2001 at 05:06:53PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2001 at 05:06:53PM +0200, Christian Bornträger wrote:
> > to test the oom killer you should try to run out of memory sometime.
> 
> I used a test program with an endless dummy=new char[1024] loop.

This loop doesn't generate any page fault, it just allocates virtual
space.

> Bytheway,I had this problem without highmem - only 512 MB, and  my problem is 

I cannot reproduce anything like that here with 512M on 2.4.11pre3aa1.
the reports I had where all with 4G of ram, in particular with the 3.5G
of virtual memory per-process on x86 which increases the pressure on the
normal zone that in turn showed me the problem.

Anyways now that I think to have seen the issues with normal zone
faliures I will try to address them soon without having to introduce
deadlock prone code into -aa. Probably not today but I hope tomorrow or
on Monday.

Andrea

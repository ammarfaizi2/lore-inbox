Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289120AbSA1NYN>; Mon, 28 Jan 2002 08:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289118AbSA1NX6>; Mon, 28 Jan 2002 08:23:58 -0500
Received: from zok.SGI.COM ([204.94.215.101]:20644 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S288302AbSA1NXg>;
	Mon, 28 Jan 2002 08:23:36 -0500
Message-ID: <3C5550BE.6040309@sgi.com>
Date: Mon, 28 Jan 2002 07:23:11 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alex Davis <alex14641@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Don't use dbench for benchmarks
In-Reply-To: <E16VBeg-0000YT-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I must be having a bad day, I can only think of irritable things to post.
>>Continuing that theme: please don't use dbench for benchmarks.  At all.
>>It's an unreliable indicator of anything in particular except perhaps
>>stability.  Please, use something else for your benchmarks.
>>
>
>Im not 100% sure that is the case. Done 30 or 40 times and done from a 
>reboot for the 30-40 pass sequence its quite a passable guide to
>both stability and I/O behaviour under some server loads. 
>

dbench tells you two things:

 o how repeatable your filesystem performance is under load from 
multiple processes,
    and is the available bandwidth equally shared between the threads. 
Various versions
    of linux (especially the elevator code) have shown different 
characteristics here, but
    nowadays things are pretty fair.

 o once you have repeatable performance it tells you if your performance 
regressed or
    improved (on identical hardware of course).

However, there are 'interesting' aspects of the test (and any other 
memory stressing
test), it performs better if you push as much out to swap as you can 
first. So I find
a dbench 8 runs better after a dbench 64 than it did before it. This 
means you need
a VERY controlled environment to make the results mean anything.

Steve

p.s. I really only use it to see if XFS can survive heavy load and 
memory pressure.




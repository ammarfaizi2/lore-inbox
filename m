Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289012AbSAFT3T>; Sun, 6 Jan 2002 14:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289013AbSAFT3J>; Sun, 6 Jan 2002 14:29:09 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:42673 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289012AbSAFT3C>;
	Sun, 6 Jan 2002 14:29:02 -0500
From: dewar@gnat.com
To: dewar@gnat.com, mrs@windriver.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020106192901.E3485F30AE@nile.gnat.com>
Date: Sun,  6 Jan 2002 14:29:01 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<?  Do you have an example where this fails?  Do you not consider it a
bug?  Now, I would place a fair amount of buren on the compiler to get
it right, though, this isn't absolute.  For example, eieieio or
>>

I don't see the obligation on the compiler here. For instance spupose
you are on an architecture where a word read is faster than a byte read.
Let's make it specific, suppose you are on a 386 and the item is 16-bits.
Now it is quicker to read 32-bits, because no prefix is required. Do you
see anything in the C standard (or the Ada standard :-) which requires a
16-bit read here? I don't, but perhaps I am missing something.

Now if you are saying that this is a reasonable expectation, nothing to do
with the standard, then that's another matter, but my example of a tradeoff
with efficiency is an interesting one.


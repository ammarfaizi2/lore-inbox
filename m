Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTFGF0J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 01:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTFGF0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 01:26:09 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:16648 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262577AbTFGF0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 01:26:07 -0400
Subject: Re: Results of actual compile printk format compression
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EE11B41.80505@techsource.com>
References: <3EE11B41.80505@techsource.com>
Content-Type: text/plain
Message-Id: <1054964378.586.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 07 Jun 2003 07:39:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-07 at 00:52, Timothy Miller wrote:
> Just a quick note...
> 
> Although my experiments with kernel printk format string compression 
> have reported estimated shrinkage, this is the first time I have been 
> able to compile a whole kernel with the compression filter.
> 
> These results come from doing an allyesconfig of 2.5.68 and then weeding 
> out anything that didn't build.  One program extracts strings from 
> preprocessor output, a second program determines how the strings will be 
> encoded, and the third makes substitutions during a kernel compile.
> 
> The uncompressed compile resulted in a kernel image of 24011892 bytes. 
> The resulting image with format strings compressed is 23904708 bytes 
> which is a shrinkage of 107184 bytes.  Subtracting out an estimate of 3K 
> for the dictionary and necessary modifications to printk, that results 
> in a reduction of something like 104112 which is 4% of the original 
> kernel size.
> 
> That may not seem like a lot, but if you consider only the printk 
> strings themselves, they are compressed to less than 50% of their 
> original size (counting the dictionary but not printk code mods).
> 
> So, I ask... is this a useful savings?  Is there any chance anyone would 
> bother to increase their compile time by a factor of 5 in order to shave 
> off 4% or 100k bytes?
> 
> (Not to mention that allyesconfig is a very unrealistic scenario.)

Sincerely, with machines ranging 512MB of memory, 100KB of memory saving
is just so little, that factoring kernel compilation by 5 is something
I'm not willing to take.

However, it could be useful to include that feature for memory
constrained systems, like embedded ones, and allow enabling it at
compile/configure time.


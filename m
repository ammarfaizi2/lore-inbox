Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRKSKDo>; Mon, 19 Nov 2001 05:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277294AbRKSKDe>; Mon, 19 Nov 2001 05:03:34 -0500
Received: from suphys.physics.usyd.edu.au ([129.78.129.1]:12029 "EHLO
	suphys.physics.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S277165AbRKSKDS> convert rfc822-to-8bit; Mon, 19 Nov 2001 05:03:18 -0500
Date: Mon, 19 Nov 2001 21:03:01 +1100 (EST)
From: Tim Connors <tcon@Physics.usyd.edu.au>
To: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <3BF839AA.4050508@wanadoo.fr>
Message-ID: <Pine.SOL.3.96.1011119210005.12304A-100000@suphys.physics.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, [ISO-8859-15] François Cami wrote:

> Dan Maas wrote:
> 
> 
> > Still, it puzzles me why a system with no swap space would appear to be more
> > responsive than one with swap (assuming their working sets are quite a bit
> > smaller than total amount of RAM)... Can you do a controlled test somehow,
> > to rule out any sort of placebo effect?
> 
> It's pretty simple... Try putting as much progs as you can into RAM
> (but less than total RAM size) when you have RAM+swap.
> Switching from one prog to another now takes time, because if you need
> to go e.g. from mozilla to openoffice for example, if openoffice has
> been swapped, it'll take ages.
> 
> Another good example is launching X and a few heavy X apps, going back
> to console, doing a few things, like compiling different kernel trees.
> If you have swap, the X + X apps will be swapped. going back to X will
> take ages, because all that data + code has to be moved out to RAM to
> cache the data in the two kernel trees.
> If you don't have swap, maybe one, or both of the two kernel trees
> will end up being not cached into main memory, depending on how much
> RAM left you have. but going back to X will take 1 second instead of 20,
> and thus the system will be more responsive.
> 
> It depends clearly on the situation you're in. I believe running with
> swap is beneficial when your memory load is more than 75% of total
> RAM, and less so when you have a few hundred megs of RAM left with all
> useful apps loaded into RAM (which is not too unlikely these days,
> due to the low price of SD/DDR RAM).

A perfect example of why a system _needs_ tuning knobs - this view of
Linus's that we need a self tuning system is idiotic, because some of us
don't care how long a kernel compile takes (or even how long it takes to
serve a couple of web pages per hour), but _do_ care about the general
system responsiveness. The system cannot predict what *I* the user wants
out of it. Hence we need /proc interfaces to the the VM that say this is a
compiling machine, or this is a desktop machine.....

-- 
TimC -- http://www.physics.usyd.edu.au/~tcon/

cat ~/.signature
Passing cosmic ray (core dumped)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279627AbRKRWlV>; Sun, 18 Nov 2001 17:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281490AbRKRWlB>; Sun, 18 Nov 2001 17:41:01 -0500
Received: from AGrenoble-101-1-3-194.abo.wanadoo.fr ([193.253.251.194]:28301
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S279627AbRKRWkw> convert rfc822-to-8bit; Sun, 18 Nov 2001 17:40:52 -0500
Message-ID: <3BF839AA.4050508@wanadoo.fr>
Date: Sun, 18 Nov 2001 23:43:54 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Dan Maas <dmaas@dcine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <fa.inl6g6v.1mmbp4@ifi.uio.no> <fa.heevhav.sjs8an@ifi.uio.no> <053d01c1707e$8c941630$1a01a8c0@allyourbase>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Maas wrote:


> Still, it puzzles me why a system with no swap space would appear to be more
> responsive than one with swap (assuming their working sets are quite a bit
> smaller than total amount of RAM)... Can you do a controlled test somehow,
> to rule out any sort of placebo effect?

It's pretty simple... Try putting as much progs as you can into RAM
(but less than total RAM size) when you have RAM+swap.
Switching from one prog to another now takes time, because if you need
to go e.g. from mozilla to openoffice for example, if openoffice has
been swapped, it'll take ages.

Another good example is launching X and a few heavy X apps, going back
to console, doing a few things, like compiling different kernel trees.
If you have swap, the X + X apps will be swapped. going back to X will
take ages, because all that data + code has to be moved out to RAM to
cache the data in the two kernel trees.
If you don't have swap, maybe one, or both of the two kernel trees
will end up being not cached into main memory, depending on how much
RAM left you have. but going back to X will take 1 second instead of 20,
and thus the system will be more responsive.

It depends clearly on the situation you're in. I believe running with
swap is beneficial when your memory load is more than 75% of total
RAM, and less so when you have a few hundred megs of RAM left with all
useful apps loaded into RAM (which is not too unlikely these days,
due to the low price of SD/DDR RAM).

François


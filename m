Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310963AbSCMSPk>; Wed, 13 Mar 2002 13:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310959AbSCMSPb>; Wed, 13 Mar 2002 13:15:31 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:19466
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310950AbSCMSPU>; Wed, 13 Mar 2002 13:15:20 -0500
Date: Wed, 13 Mar 2002 10:14:17 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6: ide driver broken in PIO mode
In-Reply-To: <a6o30m$25j$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10203131001230.19703-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Linus Torvalds wrote:

> In article <Pine.LNX.4.21.0203131339050.26768-100000@serv>,
> Roman Zippel  <zippel@linux-m68k.org> wrote:
> >
> >I first noticed the problem on my Amiga, but I can reproduce it on an ia32
> >machine, when I turn off dma with hdparm.
> 
> With PIO, the current IDE/bio stuff doesn't like the write-multiple
> interface and has bad interactions. 
> 
> Jens, you talked about a patch from Supparna two weeks ago, any
> progress?

Linus,

Suparna understands the problem and it is a solution I have described,
and I have been working with her on a solution but I suspect you will not
take it.  Because it requires an in process operation of traversing
several BIOS' in order to statisfy the hardware atomic.  Until you figure
out, you can not have the partial completion update to the granularity of
a single page or single bio it can not be fixed.  You have to permit the
hardware to satisfy its needs and have an active in process list it will
never work.

So let me know when you want a solution that is correct and proper to the
hardward and then it will be fixed.  If you continue to refuse the correct
and proper state diagram operation, you will continue to play fast and
loose with people's data.

The fact is a few people understand the problem and the solution.
By now I think you are just now getting the problem.

You can have your partial completions, but you are not going to have them
on your granularity scale, period.

If you want them on your granularity scale, you will carry the
responsiblity of "FAST and LOOSE with the DATA".

Regards,

Andre Hedrick


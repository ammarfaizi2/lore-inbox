Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSFLUvs>; Wed, 12 Jun 2002 16:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSFLUvr>; Wed, 12 Jun 2002 16:51:47 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:23221 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S314284AbSFLUvm>; Wed, 12 Jun 2002 16:51:42 -0400
Date: Wed, 12 Jun 2002 12:20:50 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Anjali Kulkarni <anjali@indranetworks.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: scheduler problems
Message-ID: <20020612122050.A1832@linux-m68k.org>
In-Reply-To: <200206120714.AAA07894@eagle.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 12:14:09AM -0700, Anjali Kulkarni wrote:
> 
> > (given that the current 2.2 kernel is 2.2.21, the first thing would 
> be to
> > test it there too.)
> > 
> 
> Thanks, I 'll do that.
> 
> > > [...] It is due to the fact that the schedule() function does not 
> find
> > > the 'current' process in the runqueue. [...]
> > 
> > a crash in line 384 means that the runqueue got corrupted by 
> something,
> > most likely caused by buggy kernel code outside of the scheduler.
> 
> Right, I thought of that, but how is it that it gets corrupt at exactly 
> the same offset in task_struct of that process and every time with 
> different processes? (I have run it atleast 20-30 times). And it just 
> doesnt come if I kill the process in question? 

I've had similar problems when some code invalidated CPU cache 
and an interrupt came in at the wrong time.

Richard

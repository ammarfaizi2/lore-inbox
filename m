Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312581AbSDJLST>; Wed, 10 Apr 2002 07:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312584AbSDJLSS>; Wed, 10 Apr 2002 07:18:18 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:45185 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312581AbSDJLSS>; Wed, 10 Apr 2002 07:18:18 -0400
Date: Wed, 10 Apr 2002 13:03:49 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: t.sailer@alumni.ethz.ch
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ESS Solo1 screeching noise on playback
In-Reply-To: <3CB41DBA.2347C053@scs.ch>
Message-ID: <Pine.LNX.4.44.0204101257390.9710-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Thomas Sailer wrote:

> I know that this is one of the problems of the driver. An even worse
> problem is that on my rev 1 chip recording does not work.
> 
> Unfortunately, I don't know how to solve any of these problems without
> the help of ESS. And ESS has been unwilling to help. Without help,
> the best one can do is "shoot in the dark".

Thanks for the feedback, what do you think of the following?

Could the screech possibly be caused by that tight loop where we try and 
push a command through in write_seq? Apparently its possible for a DMA 
completion to occur whilst that is happening (should the command be 
aborted?) Right at that moment a DMA completion interrupt also gets 
generated i believe, so would completing the command we were trying to 
send bork things somewhat? Am i right in thinking that we are DMAing 
garbage during that screeching noise?

Yes i am clutching at straws here ;)

As an aside, i noticed in the documentation, they specify that if dmasize 
is N we should send N to iobase+4 and not N-1 like an i8237.

Thanks,
	Zwane
-- 
http://function.linuxpower.ca
		


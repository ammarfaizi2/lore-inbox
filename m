Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319242AbSHWUKm>; Fri, 23 Aug 2002 16:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319262AbSHWUKm>; Fri, 23 Aug 2002 16:10:42 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:3218 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S319242AbSHWUKl>; Fri, 23 Aug 2002 16:10:41 -0400
Message-ID: <3D669737.67ED34AF@austin.ibm.com>
Date: Fri, 23 Aug 2002 15:12:40 -0500
From: Bill Hartner <hartner@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Mala Anand <manand@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
       alan@lxorguk.ukuu.org.uk, Bill Hartner <bhartner@us.ibm.com>,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
References: <OF1AAF39E9.D733B26C-ON87256C1E.004ACC87@boulder.ibm.com> <3D666531.4020909@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Hansen wrote:
> 
> Mala Anand wrote:
> > Readprofile ticks are not as accurate as the cycles I measured.
> > Moreover readprofile can give misleading information as it profiles
> > on timer interrupts. The alloc_skb and __kfree_skb call memory
> > management routines and interrupts are disabled in many parts of that code.
> > So I don't trust the readprofile data.
> 
> I don't believe your results to be accurate.  They may be _precise_
> for a small case, but you couldn't have been measuring them for very
> long.  A claim of accuracy requires a large number of samples, which
> you apparently did not do.

Dave,

What is your definition of a "very long time" ?

Read the 1st email.  There were 2.4 million samples.

How many do you think is sufficient ?

> 
> I can't use oprofile or other NMI-based profilers on my hardware, so
> we'll just have to guess.  Is there any chance that you have access to
> a large Specweb setup on hardware that is close to mine and can run
> oprofile?

Why do you think oprofile is a better way to measure this ?
BTW, Mala works with Troy Wilson who is running SPECweb99 on
an 8-way system using Apache.  Troy has run with Mala's patch
and that data will be posted.

> 
> Where are interrupts disabled?   I just went through a set of kernprof
> data and traced up the call graph.  In the most common __kfree_skb
> case, I do not believe that it has interupts disabled.  I could be
> wrong, but I didn't see it.

What is the revelance of the above ?

> 
> http://www.sr71.net/~specweb99/old/run-specweb-2300-nodynpost-2.5.31-bk+profilers-08-14-2002-02.19.22/callgraph
> 
> The end result, as I can see it, is that your patches hurt Specweb
> performance.

Based on what ?  A callgraph ? A profile ? 

Bill

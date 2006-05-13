Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWEMMKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWEMMKz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWEMMKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:10:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:35989 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932393AbWEMMKz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:10:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GUMURnIGnuvVazvfB6j6ORwzvoNLhrmQTE7CXoe9EzpnEvDizoqGXjQTnRWy9Bb0MRoh+gODe28YB1Cx9dWTX3VXCTnnOImPwmNO3Gryj1stBK9D4i7eOvoS84e2oCgUmBjVXixalaw14yqajPdukQXK+1fMZxeNkwZ2P2nloVo=
Message-ID: <ae649ba00605130510p6435e756h86f310f814c14b66@mail.gmail.com>
Date: Sat, 13 May 2006 17:40:54 +0530
From: "Krishna Chaitanya" <lnxctnya@gmail.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: Linux for Asymmetric Multi Processing Systems.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060512185426.GC2837@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ae649ba00605112354k5b91cb0cwb5e67723f6560720@mail.gmail.com>
	 <20060512185426.GC2837@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

Each Processor has its own RAM and the main ARM9 processor can access
the ARM7 Memory Map through a _Shared RAM_.

In other words, the Memory Map of ARM7 processors is visible to ARM9 processor.

Finally there are 3 RAMs:
1) System RAM (ARM9)
2) Shared RAM (the Common Memory)
3) Local RAM for ARM7s.

Basically, this is a _flexible_ mechanism to control the _visibility_
of Each Processor.

And the Memory Controller can do either _cached_ or _non-cached_ operations.

Regards,
krs

On 5/13/06, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> On Fri, May 12, 2006 at 12:24:20PM +0530, Krishna Chaitanya wrote:
> > I am working on a project where the hardware is Asymmetric Multi
> > Processing Systems(ASMP).
> >
> > In my system I have one ARM9,  four ARM7s'.
> >
> > 1. Can I use one Linux Kernel for all the CPUs in an ASMP system. (or)
> >    Should I use One Linux Kernel for ARM9 and RTOSes for ARM7.
> > 2. If my hardware would come up in future with another ARM7 does linux
> > scale for the new CPU.
> >
> > Can anyone please direct me to the source/docs how to use Linux for
> > ASMP systems.
>
> So you have two different instruction sets (although I think the arm7 is
> a subset of the arm9, but what do I know), running different clocks
> speeds most likely.
>
> Does each cpu have it's own ram, or do they all share one pool of memory?
>
> How does the Cell processor systems deal with this?
>
> Len Sorensen
>

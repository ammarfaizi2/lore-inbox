Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287467AbSAURQE>; Mon, 21 Jan 2002 12:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287478AbSAURPz>; Mon, 21 Jan 2002 12:15:55 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:63754 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287467AbSAURPo>;
	Mon, 21 Jan 2002 12:15:44 -0500
Date: Mon, 21 Jan 2002 10:15:06 -0700
From: yodaiken@fsmlabs.com
To: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121101506.A14884@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <3C4C42EE.BAEBE8CB@loewe-komp.de> <20020121094554.A14139@hq.fsmlabs.com> <3C4C4C1A.9F7CE37@loewe-komp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3C4C4C1A.9F7CE37@loewe-komp.de>; from pwaechtler@loewe-komp.de on Mon, Jan 21, 2002 at 06:12:58PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 06:12:58PM +0100, Peter Wächtler wrote:
> > Since the preemption patch only allows additional preemption in kernel
> > mode, I'm curious to know what the compute bound tasks are doing in
> > kernel mode. Did Linux add in-kernel matrix multiplication while
> > I was not looking?
> > 
> 
> Dead right you are.
> Then there are only slow system calls left. Umh, execve(), fork()
> (with big address space) - what about page_launder etc.?

Those are, in some sense, I/O right? It's not clear to me
that preempting page_launder is sensible.

> But what is a possible explanation for the people, who think their 
> systems behave better with preemption - strong believe?

Beats me. Maybe it really does work - but maybe not and nobody
has advanced any analysis or numbers that make the case.



-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292481AbSCPS6H>; Sat, 16 Mar 2002 13:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292832AbSCPS56>; Sat, 16 Mar 2002 13:57:58 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:14858 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S292481AbSCPS5s>;
	Sat, 16 Mar 2002 13:57:48 -0500
Date: Sat, 16 Mar 2002 11:57:26 -0700
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: yodaiken@fsmlabs.com, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316115726.B19495@hq.fsmlabs.com>
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com> <Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Mar 16, 2002 at 10:45:46AM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 10:45:46AM -0800, Linus Torvalds wrote:
> 
> On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:
> 
> > On Sat, Mar 16, 2002 at 10:06:06AM -0800, Linus Torvalds wrote:
> > > We'll end up (probably five years from now) re-doing the thing to allow 
> > > four levels (so a tired old x86 would fold _two_ levels instead of just 
> > > one, but I bet they'll still be the majority), simply because with three 
> > > levels you reasonably reach only about 41 bits of VM space.
> > 
> > Why so few bits per level? Don't you want bigger pages or page clusters?
> 
> Simply because I want to be able to share the software page tables with 
> the hardware page tables.

Isn't this only an issue when the hardware wants to search the tables?
So for a semi-sane architecture, the hardware idea of pte is only important
in the tlb.

is there a 64 bit machine with hardware search of pagetables? Even ibm
only has a hardware search of hash tables - which we agree are simply
a means of making your hardware TLB larger and slower.





-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com


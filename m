Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288006AbSAVCGd>; Mon, 21 Jan 2002 21:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289116AbSAVCGX>; Mon, 21 Jan 2002 21:06:23 -0500
Received: from dsl-213-023-039-080.arcor-ip.net ([213.23.39.80]:39054 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289112AbSAVCGT>;
	Mon, 21 Jan 2002 21:06:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 22 Jan 2002 03:10:42 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, george anzinger <george@mvista.com>,
        Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <1011650506.850.483.camel@phantasy> <20020121165659.A20501@hq.fsmlabs.com>
In-Reply-To: <20020121165659.A20501@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16SqOY-0001mL-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 22, 2002 12:56 am, yodaiken@fsmlabs.com wrote:
> I have not seen that argued - certainly I have not argued it myself.
> My argument is:
> 	It makes the kernel _much_ more complex

The patch itself is simple, so this must be an extended interpretation of the 
word 'complex'.

> 	It has known costs e.g. by making the lockless 
> 		per-processor caching  more difficult if not impossible

Not at all, the lazy man's way of dealing with this is to disable preemption 
around that code, an efficient operation.

> 	It seems to lead to a requirement for inheritance

I don't know about that.  From the (long) thread above, it looks like you 
haven't successfully proved the assertion that -preempt introduces any new 
inheritance requirement.

> 	It has no demonstrated benefits.

Demonstrated to who?  I have certainly demonstrated the benefits to myself, 
and others have attested to doing the same.

As far as arguments go, your main points don't seem to be rooted in firm 
ground at all.  On the other hand, the proponents of this patch have 
compelling arguments: it makes Linux feel smoother, it makes certain tests 
run faster, it doesn't slow anything down measurably, it's stable and so on.  
I even explained why it does what it does.  I don't understand why you're so 
vehemently opposed to this, especially as it's a config option.

--
Daniel

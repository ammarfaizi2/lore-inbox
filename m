Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319036AbSH1W4h>; Wed, 28 Aug 2002 18:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319037AbSH1W4h>; Wed, 28 Aug 2002 18:56:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31740 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S319036AbSH1W4g>;
	Wed, 28 Aug 2002 18:56:36 -0400
Message-ID: <3D6D560F.A22377B9@mvista.com>
Date: Wed, 28 Aug 2002 16:00:31 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
References: <Pine.LNX.4.33.0208281406190.16824-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 28 Aug 2002, Dominik Brodowski wrote:
> >
> > "policy input" --> "frequency input" --> cpufreq core --> cpufreq driver
> >   user-space    |                 k e r n e l  -  s p a c e
> 
> No.
> 
> The "policy input" has to filter down ALL THE WAY. If you turn it into a
> frequency-only input at _any_ time, you've lost information that the
> lowest levels need.
> 
> THAT is the problem with the current #3 - it _assumes_ that the policy
> input has already been converted to frequency, and since it assumes that,
> it cannot handle the case where the hardware itself wants to know what the
> policy was.

I wonder about converting it to frequency at most any
level.  Why not some abstract such as % of full speed, or %
of full power.  I, for one, don't want to have to think
absolute numbers.  First thing you know I will have a new
box with different numbers.  Then what?
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

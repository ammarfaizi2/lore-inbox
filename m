Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSGJUjZ>; Wed, 10 Jul 2002 16:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317611AbSGJUjY>; Wed, 10 Jul 2002 16:39:24 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:24524 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S317610AbSGJUjY>; Wed, 10 Jul 2002 16:39:24 -0400
Date: Wed, 10 Jul 2002 23:41:56 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Robert Love <rml@tech9.net>
Cc: Cort Dougan <cort@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  July 10, 2002
Message-ID: <20020710204156.GH1465@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Robert Love <rml@tech9.net>, Cort Dougan <cort@fsmlabs.com>,
	linux-kernel@vger.kernel.org
References: <3D2B89AC.25661.91896FEB@localhost> <1026323661.1178.73.camel@sinai> <20020710191824.GT1548@niksula.cs.hut.fi> <1026331418.1244.82.camel@sinai> <20020710142005.U762@host110.fsmlabs.com> <1026332738.1244.86.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026332738.1244.86.camel@sinai>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 01:25:38PM -0700, you [Robert Love] wrote:
> On Wed, 2002-07-10 at 13:20, Cort Dougan wrote:
> 
> > Why was the rate incremented to maintain interactive performance?  Wasn't
> > that the whole idea of the pre-empt work?  Does the burden of pre-empt
> > actually require this?
> 
> I did not say it was increased to improve interactivity response - and
> it certainly has little or nothing to do with kernel preemption being
> merged.
> 
> I suspect a big benefit would be poll/select performance.  I think this
> is why RedHat increased HZ in their kernels.

Red Hat Limbo ChangeLog says:

"The kernel used in this release supports the following list of improvements
and new features. The kernel is based on the 2.4.19- pre10-ac2 release for
this beta."

"HZ=1000 on i686 and Athlon means that the system clock ticks 10 times as
fast as on other x86 platforms (i386 and i586); HZ=100 has been the Linux
default on x86 platforms for the entire history of the Linux kernel. This
change provides better interactive response, lower latency response from
some programs, and better response from the scheduler. We have adjusted the
/proc filesystem to report numbers as if using the default HZ=100, but it is
possible that issues could arise -- please test and report bugs, as always."

So they aim for interactive response. Otoh, I think they don't include
pre-emp nor any low-lat work. I might be wrong. But the network console and
crash dump functionality they include (by Ingo Molner, I reckon) seems
sweet.


-- v --

v@iki.fi

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135734AbRDXUPr>; Tue, 24 Apr 2001 16:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135735AbRDXUPh>; Tue, 24 Apr 2001 16:15:37 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:39691 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S135734AbRDXUP2>; Tue, 24 Apr 2001 16:15:28 -0400
Date: Tue, 24 Apr 2001 14:15:25 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
Message-ID: <20010424141525.A1066@mail.harddata.com>
In-Reply-To: <cpx7l0g3mfk.fsf@goat.cs.wisc.edu> <20010423161148.6465.qmail@theseus.mathematik.uni-ulm.de> <9c48gv$fbk$1@penguin.transmeta.com> <20010424165632.3728.qmail@theseus.mathematik.uni-ulm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010424165632.3728.qmail@theseus.mathematik.uni-ulm.de>; from ehrhardt@mathematik.uni-ulm.de on Tue, Apr 24, 2001 at 06:56:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 06:56:32PM +0200, Christian Ehrhardt wrote:
> On Tue, Apr 24, 2001 at 09:10:07AM -0700, Linus Torvalds wrote:
> > ptrace only operates on processes that are stopped. So there are no
> > locking issues - we've synchronized on a much higher level than a
> > spinlock or semaphore.
> 
> This is only true for requests other than PTRACE_ATTACH and
> PTRACE_ATTACH is exactly what I'm worried about.

May I remind everybody that at the beginning of this thread I posted
another example, from an SMP Alpha, of FPU problems.  It certainly
was not exactly like the one under discussion but it looked that
it had a similar "smell" to it.

It looks like that to reproduce this Alpha example one needs processors
with a rather fast clock and this hardware version is not yet very
widely available.

  Michal

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbRDSRr7>; Thu, 19 Apr 2001 13:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRDSRrt>; Thu, 19 Apr 2001 13:47:49 -0400
Received: from tantale.fifi.org ([216.15.47.52]:29839 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S131626AbRDSRrg>;
	Thu, 19 Apr 2001 13:47:36 -0400
To: Jason Gunthorpe <jgg@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lost O_NONBLOCK (Bug?)
In-Reply-To: <Pine.LNX.3.96.1010413141220.7113E-100000@wakko.deltatee.com>
From: Philippe Troin <phil@fifi.org>
Date: 19 Apr 2001 10:47:32 -0700
In-Reply-To: <Pine.LNX.3.96.1010413141220.7113E-100000@wakko.deltatee.com>
Message-ID: <87n19czsqz.fsf@tantale.fifi.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gunthorpe <jgg@debian.org> writes:

> On 12 Apr 2001, Philippe Troin wrote:
> 
> > Apt I guess ? It has a very strange behavior when backgrounded...
> 
> Not really, just want it tries to run dpkg it hangs.
> 
> > > The last read was after the process was forgrounded. The read waits
> > > forever, the non-block flag seems to have gone missing. It is also a
> > > little odd I think that it repeated to get SIGTTIN which was never
> > > actually delivered to the program.. Shouldn't SIGTTIN suspend the process?
>  
> > Strace can perturbate signal delivery, especially for terminal-related
> > signals, I wouldn't trust it...
> 
> I know, the problem still happens without strace.

Do you have a snippet that can reproduce the problem ? Does this
happens only with 2.4, or both 2.2 and 2.4 have the problem ?

> > O_NONBLOCK is not lost... Attempting to read from the controlling tty
> > even from a O_NONBLOCK descriptor will trigger SIGTTIN.
> 
> I don't really care about the SIGTTIN, what bugs me is that the read that
> happens after the process has been foregrounded blocks - and that should
> not be.

True.

8< snip >8

Phil.

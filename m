Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbRGYI6c>; Wed, 25 Jul 2001 04:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266715AbRGYI6N>; Wed, 25 Jul 2001 04:58:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28463 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266712AbRGYI6C>; Wed, 25 Jul 2001 04:58:02 -0400
To: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
Cc: Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: about serial console problem
In-Reply-To: <20010723065212.31153.qmail@web13901.mail.yahoo.com>
	<m17kwyhyuz.fsf@frodo.biederman.org>
	<20010724232909.A27546@xyzzy.clara.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jul 2001 02:52:06 -0600
In-Reply-To: <20010724232909.A27546@xyzzy.clara.co.uk>
Message-ID: <m1r8v5gzm1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Robert J.Dunlop" <rjd@xyzzy.clara.co.uk> writes:

> Hi,
> 
> On Tue, Jul 24,  Eric W. Biederman wrote:
> > Barry Wu <wqb123@yahoo.com> writes:
> > 
> > > I am porting linux 2.4.3 to our mipsel evaluation
> > > board. Now I meet a problem. Because I use edown
> > > to download the linux kernel to evaluation board.
> > > I update the serial baud rate to 115200.
> > > I use serial 0 as our console, and I can use
> > > printk to print debug messages on serial port.
> > > But after kernel call /sbin/init, I can not
> > > see "INIT ...  ..." messages on serial port.
> > > I suppose perhaps I make some mistakes. But when
> > > I use 2.2.12 kernel, it ok.
> > > If someone knows, please help me. Thanks!
> > 
> > It's a bug in init.  INIT clears the CREAD flag which means all reads
> > to the console will be dropped.  Why it /sbin/init works before 2.4.3
> > is a mystery.
> 
> Perhaps because most of the serial drivers didn't implement CREAD (or
> rather !CREAD) until then. 

Hmm.  When I looked it appeared CREAD should have worked in 2.4.2 but I do
know /sbin/init didn't have a problem with that one.  

> Actually more and more have been implementing
> it as we go through 2.4.x, depends when your particular driver got caught.

Do you know the history on how/why ~CREAD support started showing in
in the linux kernels.  I'd like to understand what is going on.

Eric


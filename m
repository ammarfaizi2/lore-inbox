Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268496AbRGXW3g>; Tue, 24 Jul 2001 18:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268507AbRGXW30>; Tue, 24 Jul 2001 18:29:26 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:27662 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S268496AbRGXW3Q>; Tue, 24 Jul 2001 18:29:16 -0400
Date: Tue, 24 Jul 2001 23:29:09 +0100
From: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: about serial console problem
Message-ID: <20010724232909.A27546@xyzzy.clara.co.uk>
In-Reply-To: <20010723065212.31153.qmail@web13901.mail.yahoo.com> <m17kwyhyuz.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m17kwyhyuz.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Tue, Jul 24, 2001 at 09:27:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

On Tue, Jul 24,  Eric W. Biederman wrote:
> Barry Wu <wqb123@yahoo.com> writes:
> 
> > I am porting linux 2.4.3 to our mipsel evaluation
> > board. Now I meet a problem. Because I use edown
> > to download the linux kernel to evaluation board.
> > I update the serial baud rate to 115200.
> > I use serial 0 as our console, and I can use
> > printk to print debug messages on serial port.
> > But after kernel call /sbin/init, I can not
> > see "INIT ...  ..." messages on serial port.
> > I suppose perhaps I make some mistakes. But when
> > I use 2.2.12 kernel, it ok.
> > If someone knows, please help me. Thanks!
> 
> It's a bug in init.  INIT clears the CREAD flag which means all reads
> to the console will be dropped.  Why it /sbin/init works before 2.4.3
> is a mystery.

Perhaps because most of the serial drivers didn't implement CREAD (or
rather !CREAD) until then. Actually more and more have been implementing
it as we go through 2.4.x, depends when your particular driver got caught.

-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk

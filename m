Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422801AbWHYTcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbWHYTcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWHYTcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:32:12 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:28944 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422799AbWHYTcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:32:10 -0400
Date: Fri, 25 Aug 2006 20:32:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>, linux-serial@vger.kernel.org,
       "'LKML'" <linux-kernel@vger.kernel.org>, libc-alpha@sources.redhat.com
Subject: Re: Serial custom speed deprecated?
Message-ID: <20060825193203.GB725@flint.arm.linux.org.uk>
Mail-Followup-To: Stuart MacDonald <stuartm@connecttech.com>,
	'Alan Cox' <alan@lxorguk.ukuu.org.uk>,
	'Krzysztof Halasa' <khc@pm.waw.pl>, linux-serial@vger.kernel.org,
	'LKML' <linux-kernel@vger.kernel.org>,
	libc-alpha@sources.redhat.com
References: <1156459387.3007.218.camel@localhost.localdomain> <043501c6c85a$1eb09a60$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043501c6c85a$1eb09a60$294b82ce@stuartm>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 11:21:21AM -0400, Stuart MacDonald wrote:
> From: On Behalf Of Alan Cox
> > We could implement an entirely new TCSETS/TCGETS/TCSETSA/SAW 
> > which used
> > different B* values so B9600 was 9600 etc and the data was stored in
> 
> I think if a numeric baud rate is going to be supported, getting away
> from the B* cruft is important. Just use a number.

The "B* cruft" is part of POSIX so needs to be retained.  These are
used in conjunction with with cfgetispeed(), cfgetospeed(), cfsetispeed()
and cfsetospeed() to alter the baud rate settings in the termios
structure in an implementation defined manner.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

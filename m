Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270066AbTG1PgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 11:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270069AbTG1PgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 11:36:06 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:10244 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270066AbTG1PgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 11:36:04 -0400
Date: Mon, 28 Jul 2003 17:51:18 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
       Chris Heath <chris@heathens.co.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 problem
Message-ID: <20030728155118.GA1761@win.tue.nl>
References: <20030728145452.GA1753@win.tue.nl> <Pine.GSO.3.96.1030728173054.15233C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030728173054.15233C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 05:43:51PM +0200, Maciej W. Rozycki wrote:
> On Mon, 28 Jul 2003, Andries Brouwer wrote:
> 
> > > Well, are timeouts needed at all?
> > 
> > Yes. We send a command to the keyboard. It may react, or it may not.
> 
>  But we need not wait for that actively.  If we are unsure about a result
> of a command, then we may send a command in question followed with an echo
> request.  This assures an IRQ will finally arrive and if no command
> response arrives before an echo response, then the keyboard ignored the
> command.  I used this approach many years ago to differ between PS/2
> keyboards (which respond with 0xfa,0xab,0x83 to a request for ID) and
> genuine PC/AT ones (which respond with lone 0xfa).  It worked. 

And what did you do for XT? :-)


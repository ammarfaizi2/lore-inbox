Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVATT2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVATT2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVATT2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:28:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42931 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261881AbVATTXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:23:14 -0500
Date: Thu, 20 Jan 2005 19:22:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050120192258.GA8683@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Richard Moser <nigelenki@comcast.net>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
	marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>,
	chrisw@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu> <41EEA86D.7020108@comcast.net> <20050120104451.GE12665@elte.hu> <41EFF581.6050108@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EFF581.6050108@comcast.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 01:16:33PM -0500, John Richard Moser wrote:
> Granted, you're somewhat more diverse than I pointed out; but I don't
> keep up on what you're doing.  The point was more that you're not a
> major security figure and/or haven't donated your life to security and
> forsaken all lovers before it like Joshua Brindle or Brad Spengler or
> whoever the anonymous guy who developes PaX is.  I guess less focus on
> the developer and more focus on the development.

But Ingo is someone who

 - is a known allround kernel hacker
 - has a trackrecord of getting things done that actually get used
 - lowlevel CPU knowledge
 - is able to comunicate with other developers very well
 - is able to make good tradeoffs
 - has taste

most of that can't be said for your personal heroes

> *shrug*  The kernel's basic initialization code is in assembly.  On 40
> different platforms.  That's pretty complex in terms of kernel code,
> which is 99.998% C.

No, the kernel initialization is not complex at all.  complexity != code size

> Which brings us to a point on (1) and (2).  You and others continue to
> pretend that SEGMEXEC is the only NX emulation in PaX.  I should remind
> you (again) that PAGEEXEC uses the same method that Exec Shield uses
> since I believe kernel 2.6.6.  In the cases where this method fails, it
> falls back to kernel-assisted MMU walking, which can produce potentially
> high overhead.

You stated that a few time.  Now let's welcome you to reality:

 - Linus doesn't want to make the tradeoffs for segment based NX-bit
   emulation in mainline at all
 - Ingo and his collegues at Red Hat want to have it, but they don't
   want to break application nor introduce the addition complexity
   of the PaX code.

Is is that hard to understand?


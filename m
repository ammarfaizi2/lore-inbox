Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWGQBAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWGQBAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 21:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWGQBAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 21:00:22 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:38009 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751565AbWGQBAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 21:00:21 -0400
Date: Sun, 16 Jul 2006 17:56:15 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Michael Krufky <mkrufky@linuxtv.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manoj Srivastava <srivasta@debian.org>
Subject: Re: Linux v2.6.18-rc2 | UTS Release version does not match current version
Message-ID: <20060717005615.GA11640@ca-server1.us.oracle.com>
Mail-Followup-To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Michael Krufky <mkrufky@linuxtv.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Manoj Srivastava <srivasta@debian.org>
References: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org> <44BA4E5E.7060803@linuxtv.org> <20060716203600.GZ11640@ca-server1.us.oracle.com> <200607162212.58880.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607162212.58880.s0348365@sms.ed.ac.uk>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 10:12:58PM +0100, Alistair John Strachan wrote:
> >
> > -UTS_RELEASE_VERSION=$(shell if [ -f include/linux/version.h ]; then	 \
> > -                 grep 'define UTS_RELEASE' include/linux/version.h | \
> > +UTS_RELEASE_VERSION=$(shell if [ -f include/linux/utsrelease.h ]; then	 \
> > +                 grep 'define UTS_RELEASE' include/linux/utsrelease.h | \
> >
> >
> > And rerun your make-kpkg.  The above is not a valid patch, you'll have
> > to hand change it.
> 
> It's probably worth letting somebody an upstream Debian maintainer know about 
> this, so that Etch can inherit it (CCed).

	I expected they'd notice really soon.  Plus, a proper fix needs
to detect which header to use (older vs newer kernels), so the above is
not viable for upstream.  But yes, I should have Cc'd :-)

Joel


-- 

"Three o'clock is always too late or too early for anything you
 want to do."
        - Jean-Paul Sartre

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

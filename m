Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVFGAxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVFGAxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVFGAxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:53:52 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:36694 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261779AbVFGAxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 20:53:50 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML binary
Date: Tue, 7 Jun 2005 02:56:36 +0200
User-Agent: KMail/1.7.2
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org> <200506070105.20422.blaisorblade@yahoo.it> <20050606235321.GJ29811@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050606235321.GJ29811@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506070256.43104.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 June 2005 01:53, Al Viro wrote:
> On Tue, Jun 07, 2005 at 01:05:19AM +0200, Blaisorblade wrote:
> > On Monday 06 June 2005 22:08, Jeff Dike wrote:
> > > From Al Viro - this turns the tt mode remapping of the binary into arch
> > > code.
> >
> > NACK at all, definitely, don't apply this one please. This patch:
> >
> > 1) On i386 does not fix the problem it was supposed to fix when I
> > originately sent the first version (i.e. avoiding to create a
> > .thread_private section to allow linking against NPTL glibc). It's done
> > on x86_64 and forgot on i386.
>
> True.  i386 still assumes non-NPTL (as it is on the box I'm working on -
> such setups *do* exist).
Yes, it's the most common one, and it's even the setup for my box currently.
> > 2) Splitting the linker script for subarchs is definitely not needed.
>
> Per-subarch - perhaps not.  Per-glibc-type - definitely needed.
No, because the setup for NPTL glibc works also on non-NPTL one. Actually, to 
be exact, I've tested it *only* on normal glibc. I'm still waiting to get 
some testing in NPTL environments, but I expect it to work.
> > 3) This removes the fix (done through objcopy -G switcheroo) to a link
> > time conflict happening on some weird glibc combinations.

> *What* link-time conflict?  We don't link libc into switcheroo anymore.
Hmm, yes, I noted this... and maybe it could even be good (it makes sense, at 
least). Probably you are right on this, too.

P.S: is it only me or you've sent about 20 copies of your last message?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it

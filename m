Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUF1Ikw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUF1Ikw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 04:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbUF1Ikw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 04:40:52 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:11782 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264519AbUF1Iku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 04:40:50 -0400
Subject: Re: [PATCH] Staircase scheduler v7.4
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
In-Reply-To: <Pine.LNX.4.58.0406281013590.11399@kolivas.org>
References: <200406251840.46577.mbuesch@freenet.de>
	 <200406261929.35950.mbuesch@freenet.de>
	 <1088363821.1698.1.camel@teapot.felipe-alfaro.com>
	 <200406272128.57367.mbuesch@freenet.de>
	 <1088373352.1691.1.camel@teapot.felipe-alfaro.com>
	 <Pine.LNX.4.58.0406281013590.11399@kolivas.org>
Content-Type: text/plain
Date: Mon, 28 Jun 2004 10:40:44 +0200
Message-Id: <1088412045.1694.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-28 at 10:15 +1000, Con Kolivas wrote:
> On Sun, 27 Jun 2004, Felipe Alfaro Solana wrote:
> 
> > On Sun, 2004-06-27 at 21:28 +0200, Michael Buesch wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > Quoting Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>:
> > > > On Sat, 2004-06-26 at 19:29 +0200, Michael Buesch wrote:
> > > > 
> > > > > Now another "problem":
> > > > > Maybe it's because I'm tired, but it seems like
> > > > > your fix-patch made moving windows in X11 is less smooth.
> > > > > I wanted to mention it, just in case there's some other
> > > > > person, who sees this behaviour, too. In case I'm the
> > > > > only one seeing it, you may forget it. ;)
> > > > 
> > > > I can see the same with 7.4-1 (that's 2.6.7-ck2 plus the fix-patch): X11
> > > > feels sluggish while moving windows around. Simply by loading a Web page
> > > > into Konqueror and dragging Evolution over it, makes me able to
> > > > reproduce this problem.
> > > > 
> > > > Doing the same on 2.6.7-mm3 is totally smooth, however.
> > > 
> > > I think staircase-7.7 fixed this, too. (for me).
> > > Have a try.
> > 
> > Staircase 7.7 over 2.6.7-ck2 still feels somewhat sluggish... Renicing X
> > to -5 seems to improve a bit, but -mm3 is smoother and does not require
> > renicing the X server.
> 
> Hi
> 
> I seem to have an oversight with ck in the batch implementation that may 
> be causing problems that wouldn't happen if you used the standalone 
> staircase patch. Can you try the standalone s7.7 patch (not from the split 
> out patches in the ck directory) that is in my patches/2.6/2.6.7 
> directory?

I have tested 2.6.7-bk10 plus from_2.6.7_to_staircase_7.7 patch and,
while it's definitively better than previous versions, it still feels a
little jerky when moving windows in X11 wrt to -mm3. Renicing makes it a
little bit smoother, but not as much as -mm3 without renicing.

What it shines on is the fact that the "while true; do a=2; done" loop
has no apparent effect on interactivity, that is, the system feels as
interactive as when not running this CPU hog.


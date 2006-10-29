Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965312AbWJ2Rle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbWJ2Rle (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 12:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965313AbWJ2Rle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 12:41:34 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:64221 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S965312AbWJ2Rld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 12:41:33 -0500
X-Originating-Ip: 72.57.81.197
Date: Sun, 29 Oct 2006 12:37:36 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Adrian Bunk <bunk@stusta.de>
cc: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
Subject: Re: why test for "__GNUC__"?
In-Reply-To: <20061029171855.GF27968@stusta.de>
Message-ID: <Pine.LNX.4.64.0610291223520.31583@localhost.localdomain>
References: <Pine.LNX.4.64.0610290610020.6502@localhost.localdomain>
 <Pine.LNX.4.61.0610291244310.15986@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0610290742310.7457@localhost.localdomain>
 <20061029120534.GA4906@martell.zuzino.mipt.ru>
 <Pine.LNX.4.64.0610291044230.9726@localhost.localdomain>
 <slrnek9le5.2vm.olecom@flower.upol.cz> <20061029171855.GF27968@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.54, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_20 -0.74)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2006, Adrian Bunk wrote:

> On Sun, Oct 29, 2006 at 04:17:51PM +0000, Oleg Verych wrote:
> >...
> > On 2006-10-29, Robert P. J. Day wrote:
> >>...
> > And if you can, please, help with development or bugs, not this.
>
> Cleanup of the kernel source is also a valuable task (and as a side
> effect it even sometimes finds bugs).

on that note, i realize that most of my postings are addressing
nitpicky/aesthetic issues that don't actually *hurt* anything, but for
someone who's clawing his way through the kernel code for the first
time, a lot of it is unnecessarily confusing.

for better or worse, i generally assume that whatever i'm looking at
is there for a *reason* and i might spend some time puzzling over a
bit of code until it finally dawns on me that it's just historical
cruft that has no value.  it's not a bug, it just doesn't *do*
anything anymore.

in my case, it's sometimes easier to spot things like this since i'm
following along in some book, like r. love's "linux kernel
development."  so when he writes that the linux kernel is wedded to
gcc, and yet i see tests for "__GNUC__" throughout the code, my little
antenna stalks perk up a bit.

having someone point out that ICC is also an option clarifies that
briefly ... until i notice that ICC *also* defines __GNUC__ equal to
4, so i'm back to being confused.  (as an aside, i downloaded the most
recent ICC earlier today and did a test compile of the latest git
pull.  man, the stuff under scripts/ needs to be cleaned something
fierce.  :-)

then there's the apparently historical stuff related to "signed"
versus "__signed" versus "__signed__".  sure, it all works, but it's
needlessly complicated and verbose and might also lead someone astray
trying to figure out what the rationale is.  (and don't even get me
started on semaphores. :-)

in any event, i'm most emphatically *not* (yet) at the level where i'm
going to be able to contribute bleeding-edge code.  but i'm certainly
capable of poring over the *existing* code and pointing out the places
that might lead someone to mutter, "what the hell...?"

maybe there's a better forum for me to make these observations.  i'm
open to suggestions.  i've made a list of these observations and i'd
be happy to send them to the right person.

rday

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTEGBP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 21:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTEGBP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 21:15:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:13028 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262621AbTEGBP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 21:15:27 -0400
Date: Tue, 6 May 2003 18:24:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: devenyga@mcmaster.ca, rml@tech9.net, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: PATCH: Replace current->state with set_current_state in 2.5.6 8
Message-Id: <20030506182456.644b70d1.rddunlap@osdl.org>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C8FDEAD@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780C8FDEAD@orsmsx116.jf.intel.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 May 2003 17:33:26 -0700  "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com> wrote:

| > From: Gabriel Devenyi [mailto:devenyga@mcmaster.ca]
| > 
| > This patch appies to 2.5.68 and replaces any remaining current->state
| lines
| >  with set_current_state. This from the TODO list of Kernel Janitors.
| > 
| >
| http://muss.mcmaster.ca/~devenyga/patch-linux-2.5.68-set_current_state.patch
| 
| Some time ago I sent a patch doing this only on */fs/* [not the filesystem's
| code, just the common stuff]. It was dismissed by Linus under
| I-don't-know-what
| -the-hell-reasons (it's very smart to dismiss something without reason,
| gives
| the original poster a very clear idea of what needs to be changed -
| nevermind, just being ironic). 
| 
| However, I'd suggest to post this into the Kernel Janitors mailing list and
| let one of the big guys there swipe it in.
| 
| Maybe Robert Love can provide more highlight.


Yes, the KJ list has already seen this patch and commented on some version
of it.

Folks, IMO for KJ work to be successful (merged) and rewarding, and for it
to continue, we need:

- TODO list updated with accurate descriptions of problems and expected
  changes to fix them;
- a plan of attack for getting them merged;

We shouldn't just expect (for example) Gabriel's patch to be merged
on its own.

Even if Gabriel's patch is perfect, I don't expect that Linus will merge it,
esp. not now, but not even earlier in 2.5 days.  For one thing, it's
176 KB, so it needs to be broken down by subsystem/driver/filesystem/etc.

Then it needs some exposure, like living in -ac or -mm or -pick1,
or at least some testing (everyday usage) by a few people, with reports
from them.

And I don't really want to review a 176 KB patch (although I did already
look over most of it a few days ago).  Do people want to take portions
of it for review and then see about Alan merging it, e.g.?

--
~Randy

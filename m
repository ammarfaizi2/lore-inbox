Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbTIATEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTIATEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:04:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8617
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263188AbTIATEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:04:50 -0400
Date: Mon, 1 Sep 2003 21:05:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes
Message-ID: <20030901190526.GP11503@dualathlon.random>
References: <20030830154137.GK24409@dualathlon.random> <Pine.LNX.4.44.0309011553210.6008-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309011553210.6008-100000@logos.cnet>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 04:00:49PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Sat, 30 Aug 2003, Andrea Arcangeli wrote:
> 
> > On Sat, Aug 30, 2003 at 12:13:57PM -0300, Marcelo Tosatti wrote:
> > > 
> > > > You need to integrate with -aa on the VM.  It has been hard enough for
> > > > Andrea to get his stuff in, I doubt you will fair any better.
> > > 
> > > Thats because I never received separate patches which make sense one by
> > > one.  Most of Andreas changes are all grouped into few big patches that
> > > only he knows the mess. That is not the way to merge things.
> > > 
> > > I want to work out with him after I merge other stuff to address that.
> > 
> > that's true for only one patch, the others are pretty orthogonal after
> > Andrew helped splitting them:
> > 
> > 
> > 05_vm_03_vm_tunables-4
> > 05_vm_05_zone_accounting-2
> > 05_vm_06_swap_out-3
> > 05_vm_07_local_pages-4
> > 05_vm_08_try_to_free_pages_nozone-4
> > 05_vm_09_misc_junk-3
> > 05_vm_10_read_write_tweaks-3
> > 05_vm_13_activate_page_cleanup-1
> > 05_vm_15_active_page_swapout-1
> > 05_vm_16_active_free_zone_bhs-1
> > 05_vm_17_rest-10
> 
> Can you please split the watermark changes from 05_vm_rest-10 and send me
> that ? (no waitqueue changes, no page wakeup logic changes)

yes sure. (I have it already splitted here but I'm unsure if it's
uptodate or/and if still applies:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre6/zone-watermarks-1

so don't use it, I'll send a new one).

> As I said previously, lets start with the page reclaiming logic changes 
> first, which include:
> 
> 05_vm_03_vm_tunables-4
> 05_vm_05_zone_accounting-2
> 05_vm_06_swap_out-3 
> 
> And the necessary (ONLY watermark stuff AFAICS) from 05_vm_rest-10. 
> 
> Right?

Looks fine to me. Many thanks!

Andrea

/*
 * If you also refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */

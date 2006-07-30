Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWG3Ox4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWG3Ox4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWG3Ox4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:53:56 -0400
Received: from thunk.org ([69.25.196.29]:15528 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751235AbWG3Oxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:53:55 -0400
Date: Sun, 30 Jul 2006 10:53:05 -0400
From: Theodore Tso <tytso@mit.edu>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw3945 status
Message-ID: <20060730145305.GE23279@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Kasper Sandberg <lkml@metanurb.dk>,
	Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
	Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ipw2100-admin@linux.intel.com
References: <20060730104042.GE1920@elf.ucw.cz> <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org> <20060730114722.GA26046@srcf.ucam.org> <1154264478.13635.22.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154264478.13635.22.camel@localhost>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 03:01:17PM +0200, Kasper Sandberg wrote:
> > Because it would involve a moderate rewriting of the driver, and we'd 
> > have to carry a delta against Intel's code forever.
>
> without knowing this for sure, dont you think that if a largely changed
> version of the driver appeared in the tree, intel may start developing
> on that? cause then they wouldnt be the ones that "broke" compliance
> with FCC(hah) by not doing binaryonly.

It's just as likely that their lawyers would tell them that they would
have to pretend that the modifications don't exist at all, and not
release any changes for any driver (like OpenBSD's) that bypassed the
regulatory daemon.  The bigger worry would be if they decided that
they couldn't risk supporting their current out-of-tree driver, and
couldn't release Linux drivers for their softmac wireless devices in
the future.

Personally, I don't see why the requirement of an external daemon is
really considered that evil.  We allow drivers that depend on firmware
loaders, don't we?  I could imagine a device that required a digitally
signed message (using RSA) with a challenge/response protocol embedded
inside that was necessary to configure said device, which is
calculated in userspace and then passed down into the kernel to be
installed into the device so that it could function.  Do we really
want to consider that to be objectionable?

						- Ted

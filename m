Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWFJTxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWFJTxo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWFJTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:53:44 -0400
Received: from thunk.org ([69.25.196.29]:13799 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751292AbWFJTxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:53:43 -0400
Date: Sat, 10 Jun 2006 15:52:48 -0400
From: Theodore Tso <tytso@mit.edu>
To: Olivier Galibert <galibert@pobox.com>, Sven-Haegar Koch <haegar@sdinet.de>,
       Michael Poole <mdpoole@troilus.org>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610195248.GA6641@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Olivier Galibert <galibert@pobox.com>,
	Sven-Haegar Koch <haegar@sdinet.de>,
	Michael Poole <mdpoole@troilus.org>, Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <87irnab33v.fsf@graviton.dyn.troilus.org> <Pine.LNX.4.64.0606100245130.12765@mercury.sdinet.de> <20060610010651.GA20202@thunk.org> <20060610140713.GA1475@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610140713.GA1475@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 04:07:14PM +0200, Olivier Galibert wrote:
> > Incorrect, because unless you explicitly enable the use of extents,
> > the mere act of using a new kernel such as might be found on knoppix
> > will not result in the filesystem utilizing the extent feature.
> 
> And how shall the rescue/live CD know whether to use the feature?

Because there will be a bit the superblock that the user will have to
explicitly enable in order to get extents, so a new kernel on the
rescue/live CD will no whether or not extents are allowed --- just as
today, you have to explicitly enable hashed tree directory indexing
with the command, tune2fs -O dir_index /dev/hdXXX.

							- Ted

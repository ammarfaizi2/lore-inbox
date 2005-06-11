Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVFKNxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVFKNxS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 09:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVFKNxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 09:53:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36585 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261701AbVFKNxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 09:53:14 -0400
Date: Sat, 11 Jun 2005 14:54:11 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Arjan van de Ven <arjan@infradead.org>,
       Jeff Garzik <jgarzik@pobox.com>, mike.miller@hp.com, akpm@osdl.org,
       axboe@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: DMA mapping (was Re: [PATCH] cciss 2.6; replaces DMA masks with kernel defines)
Message-ID: <20050611135411.GJ24611@parcelfarce.linux.theplanet.co.uk>
References: <20050610143453.GA26476@beardog.cca.cpqcorp.net> <42A9C60E.3080604@pobox.com> <1118436000.6423.42.camel@mindpipe> <1118436306.5272.37.camel@laptopd505.fenrus.org> <1118438253.6423.72.camel@mindpipe> <20050610213003.GI24611@parcelfarce.linux.theplanet.co.uk> <1118444891.6423.130.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118444891.6423.130.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 07:08:11PM -0400, Lee Revell wrote:
> b44 needs 30 bit:
> 
> #define B44_DMA_MASK 0x3fffffff
> 
> These seem to be all over the place.  I guess it saves a tiny bit of
> silicon.  Don't these all violate the PCI spec?

No, it's permitted.  What would violate the PCI spec would be failing
to decode the full 32/64 bit address and creating aliases (like 10-bit
ISA cards did).  This is just a reestriction on which parts of memory
a card can DMA to.

> Should I just add everything from 24 to 63?

Actually, it'd be useful to have a central list of what DMA masks devices
really take.  It might provide some arguments for changing the zone allocater.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

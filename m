Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVFJV3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVFJV3S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 17:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVFJV3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 17:29:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63413 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261250AbVFJV3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 17:29:13 -0400
Date: Fri, 10 Jun 2005 22:30:03 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       mike.miller@hp.com, akpm@osdl.org, axboe@suse.de,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: DMA mapping (was Re: [PATCH] cciss 2.6; replaces DMA masks with kernel defines)
Message-ID: <20050610213003.GI24611@parcelfarce.linux.theplanet.co.uk>
References: <20050610143453.GA26476@beardog.cca.cpqcorp.net> <42A9C60E.3080604@pobox.com> <1118436000.6423.42.camel@mindpipe> <1118436306.5272.37.camel@laptopd505.fenrus.org> <1118438253.6423.72.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118438253.6423.72.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 05:17:32PM -0400, Lee Revell wrote:
> OK, this covers the drivers I know.  I didn't make any attempt to check
> them all.

I know of two others ...

sym2 has:
#define DMA_DAC_MASK    0x000000ffffffffffULL /* 40-bit */

and aic7xxx has:
        const uint64_t   mask_39bit = 0x7FFFFFFFFFULL;

Would you mind respinning your patch to include these?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

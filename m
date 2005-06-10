Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVFJXKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFJXKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVFJXKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:10:39 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31403 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261404AbVFJXHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:07:19 -0400
Subject: Re: DMA mapping (was Re: [PATCH] cciss 2.6; replaces DMA masks
	with kernel defines)
From: Lee Revell <rlrevell@joe-job.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Arjan van de Ven <arjan@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       mike.miller@hp.com, akpm@osdl.org, axboe@suse.de,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20050610213003.GI24611@parcelfarce.linux.theplanet.co.uk>
References: <20050610143453.GA26476@beardog.cca.cpqcorp.net>
	 <42A9C60E.3080604@pobox.com> <1118436000.6423.42.camel@mindpipe>
	 <1118436306.5272.37.camel@laptopd505.fenrus.org>
	 <1118438253.6423.72.camel@mindpipe>
	 <20050610213003.GI24611@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 19:08:11 -0400
Message-Id: <1118444891.6423.130.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 22:30 +0100, Matthew Wilcox wrote:
> On Fri, Jun 10, 2005 at 05:17:32PM -0400, Lee Revell wrote:
> > OK, this covers the drivers I know.  I didn't make any attempt to check
> > them all.
> 
> I know of two others ...
> 
> sym2 has:
> #define DMA_DAC_MASK    0x000000ffffffffffULL /* 40-bit */
> 
> and aic7xxx has:
>         const uint64_t   mask_39bit = 0x7FFFFFFFFFULL;

b44 needs 30 bit:

#define B44_DMA_MASK 0x3fffffff

These seem to be all over the place.  I guess it saves a tiny bit of
silicon.  Don't these all violate the PCI spec?

Should I just add everything from 24 to 63?

Lee


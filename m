Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWCBNH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWCBNH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWCBNH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:07:29 -0500
Received: from cantor2.suse.de ([195.135.220.15]:18830 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750826AbWCBNH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:07:28 -0500
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Thu, 2 Mar 2006 14:09:25 +0100
User-Agent: KMail/1.9.1
Cc: Michael Monnerie <m.monnerie@zmi.at>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
References: <200603020023.21916@zmi.at> <200603021316.38077.ak@suse.de> <20060302123033.GL4329@suse.de>
In-Reply-To: <20060302123033.GL4329@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021409.25989.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 13:30, Jens Axboe wrote:

> I'd much rather prefer punting and letting the upper layer decide how to
> handle it. Who knows, it may have to do something active like kicking
> pending io in action at the controller level.

But how would you wait for new space to be available then?

You need at least a wait queue from the IOMMU code to hook into I suspect.

-Andi

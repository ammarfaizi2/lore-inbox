Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWCBMTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWCBMTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWCBMTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:19:11 -0500
Received: from mail.suse.de ([195.135.220.2]:11989 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751216AbWCBMTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:19:10 -0500
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Thu, 2 Mar 2006 13:21:08 +0100
User-Agent: KMail/1.9.1
Cc: Andy Chittenden <AChittenden@bluearc.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <89E85E0168AD994693B574C80EDB9C270393C1BF@uk-email.terastack.bluearc.com> <20060302111046.GF4329@suse.de>
In-Reply-To: <20060302111046.GF4329@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021321.09082.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 12:10, Jens Axboe wrote:

> I'm waiting for Andi to render an opinion on the problem. It should have
> no corruption implications, the PIO path will handle arbitrarily large
> requests. I'm assuming the mapped sg table is correct, just odd looking
> for some reason.

I was waiting for feedback if iommu=nomerge changes anything. With that option
the IOMMU code will never touch the layout of the sg list, just rewrite
->dma_address

-Andi

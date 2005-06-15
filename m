Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVFOSx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVFOSx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 14:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVFOSx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 14:53:57 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:36069 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261267AbVFOSxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 14:53:55 -0400
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <42B073C1.3010908@yahoo.com.au>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
	 <42B073C1.3010908@yahoo.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1118860223.4301.449.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jun 2005 11:30:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 11:30, Nick Piggin wrote:
> Badari Pulavarty wrote:
> 
> > ------------------------------------------------------------------------
> > 
> > elm3b29 login: dd: page allocation failure. order:0, mode:0x20
> > 
> > Call Trace: <IRQ> <ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
> >        <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff80166e86>{kmem_cache_alloc+54}
> >        <ffffffff8033d021>{scsi_get_command+81} <ffffffff8034181d>{scsi_prep_fn+301}
> 
> They look like they're all in scsi_get_command.
> I would consider masking off __GFP_HIGH in the gfp_mask of that
> function, and setting __GFP_NOWARN. It looks like it has a mempoolish
> thingy in there, so perhaps it shouldn't delve so far into reserves.

You want me to take off GFP_HIGH ? or just set GFP_NOWARN with GFP_HIGH
?

- Badari


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264740AbTIDHNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbTIDHNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:13:41 -0400
Received: from verein.lst.de ([212.34.189.10]:39882 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264740AbTIDHNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:13:40 -0400
Date: Thu, 4 Sep 2003 09:13:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904071334.GA14426@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16214.34933.827653.37614@nanango.paulus.ozlabs.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:33:57AM +1000, Paul Mackerras wrote:
> I don't see why this is a problem.  The change is compatible with the
> existing uses.  We need to be able to map 36-bit physical addresses on
> 44x.  What we really need now is 64-bit start/end values in struct
> resource.

Then add the phys_addr_t to all places where we deal with physical
addresses, even if it's typedef'ed to unsigned long on all other
arches and sane ppcs.

> > /me still boggles how a patch like that could have sneaked in without
> > a review on lkml..
> 
> First, it's a PPC-only change, and secondly, it's been around for
> months in the linuxppc-2.5 tree - since June last year in fact, and
> even longer than that in the linuxppc_2_4_devel tree.  Lkml is not
> where most PPC-specific stuff gets discussed, it's too noisy for that.

ioremap is not ppc-specific.


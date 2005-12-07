Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVLGKK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVLGKK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVLGKK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:10:58 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:21661 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750774AbVLGKK6 (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 7 Dec 2005 05:10:58 -0500
Date: Wed, 7 Dec 2005 18:36:44 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: nikita@clusterfs.com, Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] mm: delayed page activation
Message-ID: <20051207103643.GA4335@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, nikita@clusterfs.com,
	Linux-Kernel@Vger.Kernel.ORG
References: <20051203071444.260068000@localhost.localdomain> <20051203071609.755741000@localhost.localdomain> <17298.56560.78408.693927@gargle.gargle.HOWL> <20051204134818.GA4305@mail.ustc.edu.cn> <17299.1331.368159.374754@gargle.gargle.HOWL> <20051205014842.GA5103@mail.ustc.edu.cn> <17301.53377.614777.913013@gargle.gargle.HOWL> <20051207014235.GA5186@mail.ustc.edu.cn> <20051207014659.512619ea.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207014659.512619ea.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 01:46:59AM -0800, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > Andrew, and anyone in the lkml, do you feel ok to test it in -mm tree?
> 
> Nope, sorry.  I am wildly uninterested in large changes to page reclaim. 
> Or to readahead, come to that.
> 
> That code has had years of testing, tweaking, tuning and poking.  Large
> changes such as these will take as long as a year to get settled into the
> same degree of maturity.  Both of these parts of the kernel are similar in
> that they are hit with an extraordinarly broad range of usage patterns and
> they both implement various predict-the-future heuristics.  They are subtle
> and there is a lot of historical knowledge embedded in there.
> 
> What I would encourage you to do is to stop developing and testing new
> code.  Instead, devote more time to testing, understanding and debugging
> the current code.  If you find and fix a problem and can help us gain a
> really really really good understanding of the problem and the fix then
> great, we can run with that minimal-sized, minimal-impact, well-understood,
> well-tested fix.
> 
> See where I'm coming from?  Experience teaches us to be super-cautious
> here.  In these code areas especially we cannot afford to go making
> larger-than-needed changes because those changes will probably break things
> in ways which will take a long time to discover, and longer to re-fix.

Ok, thanks for the advise.
My main concern is in read-ahead. The new development stopped roughly from V8. 
Various parts have been improving based on user feedbacks since V6. The future
work would be more testings/tunings and user interactions. Till now I have
received many user reports on both server/desktop, things are going on well :)

Regards,
Wu

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVK3P3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVK3P3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVK3P3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:29:08 -0500
Received: from ns1.suse.de ([195.135.220.2]:12193 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751269AbVK3P3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:29:08 -0500
Date: Wed, 30 Nov 2005 16:29:06 +0100
From: Andi Kleen <ak@suse.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
Message-ID: <20051130152906.GO19515@wotan.suse.de>
References: <20051130042118.GA19112@kvack.org> <20051130151847.GE5706@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130151847.GE5706@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 05:18:47PM +0200, Matti Aarnio wrote:
> On Tue, Nov 29, 2005 at 11:21:18PM -0500, Benjamin LaHaise wrote:
> > Date:	Tue, 29 Nov 2005 23:21:18 -0500
> > From:	Benjamin LaHaise <bcrl@kvack.org>
> > To:	Andi Kleen <ak@suse.de>
> > Cc:	linux-kernel@vger.kernel.org
> > Subject: [PATCH 0/9] x86-64 put current in r10
> > 
> > Hello Andi,
> > 
> > The following emails contain the patches to convert x86-64 to store current 
> > in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).  This 
> > provides a significant amount of code savings (~43KB) over the current 
> > use of the per cpu data area.  I also tested using r15, but that generated 
> > code that was larger than that generated with r10.  This code seems to be 
> > working well for me now (it stands up to 32 and 64 bit processes and ptrace 
> > users) and would be a good candidate for further exposure.
> 
> I would rather prefer NOT to introduce this at this time.
> My primary concern is that during "even numbered series" there
> should not be radical internal ABI/API changes, like this one.

Hmm? I am not aware of such a constraint.

It's not very invasive anyways in that it would require changing
a lot of code.

> In 2.7 it can be introduced, by all means.
> 
> Indeed at the moment my thinking is, that X86-64 is way more UNSTABLE,
> than it should be.  (And Linux kernel overall, but that is another story.)

The actual x86-64 kernel is actually quite stable, most of the reported
problems (including yours) come from various hardware or firmware
issues mostly in new platforms. If you use a trusty old chipset
(e.g. AMD 8111 or Intel E7505) and proven motherboard you're usually ok.

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVIZTby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVIZTby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVIZTby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:31:54 -0400
Received: from calsoftinc.com ([64.62.215.98]:39110 "HELO calsoftinc.com")
	by vger.kernel.org with SMTP id S1751370AbVIZTbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:31:53 -0400
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
From: Alok Kataria <alokk@calsoftinc.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
In-Reply-To: <Pine.LNX.4.62.0509261058340.3650@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.63.0509251937510.24430@alok.intranet.calsoftinc.com>
	 <Pine.LNX.4.62.0509261058340.3650@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1127763269.2893.44.camel@alok.intranet.calsoftinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 27 Sep 2005 01:04:30 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 23:30, Christoph Lameter wrote:
> On Sun, 25 Sep 2005, Alok Kataria wrote:
> 
> > As pointed by Christoph,  In kmalloc_node we are cheking if, the allocation is
> > for the
> > same node when interrupts are "on", this may lead to an allocation on another
> > node than intended.
> > This patch just shifts the check for the current node in __cache_alloc_node
> > when interrupts
> > are disabled.
> 
> Alokk, could you verify that this patch works?

Yes it does work at my end, i am still not able to reproduce the BUG so
don't know if we really fix that BUG.

> 
> Petr, could you check that this patch fixes your issue? I am a bit 
> skeptical. I do not think we have found the real problem yet. We need to 
> have some way to reproduce the problem if it still persists after applying 
> Alokk's patch.

Yep, that will help, if it still BUG's the information that you provided with verify_entry will be great.

Thanks & Regards,
Alok


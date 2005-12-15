Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422681AbVLOJ75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbVLOJ75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422676AbVLOJ75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:59:57 -0500
Received: from ns.suse.de ([195.135.220.2]:64909 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422681AbVLOJ7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:59:55 -0500
Date: Thu, 15 Dec 2005 10:59:49 +0100
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Dave <dave.jiang@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86_64 segfault error codes
Message-ID: <20051215095949.GZ23384@wotan.suse.de>
References: <8746466a0512141017j141d61dft3dd2b1ab95dc2351@mail.gmail.com> <p73hd9b8r9w.fsf@verdi.suse.de> <8746466a0512141124u68c3f5c9o3411c8af64667d8d@mail.gmail.com> <20051214195848.GQ23384@wotan.suse.de> <Pine.LNX.4.61.0512150949570.6445@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512150949570.6445@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 09:55:40AM +0000, Hugh Dickins wrote:
> On Wed, 14 Dec 2005, Andi Kleen wrote:
> > 
> > Don't know what kernel you're looking at, but 2.6.15rc5 has
> > 
> >  *      bit 0 == 0 means no page found, 1 means protection fault
> >  *      bit 1 == 0 means read, 1 means write
> >  *      bit 2 == 0 means kernel, 1 means user-mode
> >  *      bit 3 == 1 means use of reserved bit detected
> >  *      bit 4 == 1 means fault was an instruction fetch
> 
> I can't see it there in 2.6.15-rc5 or 2.6.15-rc5-git; but it is there
> in 2.6.15-rc5-mm3: which seems to contains a lot of x86_64 patches,
> perhaps some of which you're expecting already to be in 2.6.15?

Yah it's only in the 2.6.16 queue. Sorry for the confusion.

Anyways nobody should rely on these comments. If you want the details
look at the architecture manuals.

-Andi

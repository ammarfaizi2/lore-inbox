Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271031AbTGPSlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270965AbTGPSlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:41:31 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:9910 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S271031AbTGPSlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:41:19 -0400
Date: Wed, 16 Jul 2003 19:57:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Dave Jones <davej@codemonkey.org.uk>
cc: Ron Niles <Ron.Niles@falconstor.com>, David Mosberger <davidm@hpl.hp.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Question about free_one_pgd() changes in these 3.5G patches
In-Reply-To: <20030716152532.GA18350@suse.de>
Message-ID: <Pine.LNX.4.44.0307161936210.1181-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003, Dave Jones wrote:
> On Wed, Jul 16, 2003 at 01:31:39PM +0100, Hugh Dickins wrote:
> 
> Both this..
>  > >  		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
> and this..
>  > > 		prefetchw(md+(PREFETCH_STRIDE/16));
> 
> both use the prefetch that was removed in 2.5 for 'being bogus'.
> It can prefetch past the end iirc, which is fatal on some CPUs.

That prefetchw never made sense to me, nor to DavidM whom I falsely
accused of it; but I had never noticed that someone (aha - you!)
got up the courage to remove it from 2.5.  A 2.4.22 patch to Marcelo
would come with greater authority from you than from me, Dave.

Hugh


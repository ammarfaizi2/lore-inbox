Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266397AbUHCN37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUHCN37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 09:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUHCN37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 09:29:59 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:22443 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266397AbUHCN36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 09:29:58 -0400
Date: Tue, 3 Aug 2004 14:26:19 +0100
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL (fwd)
Message-ID: <20040803132619.GC12571@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@fs.tum.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040802225951.GR2746@fs.tum.de> <20040802162846.3929e463.akpm@osdl.org> <20040803004509.GW2746@fs.tum.de> <1091490958.1647.25.camel@localhost.localdomain> <20040803131339.GB2746@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803131339.GB2746@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 03:13:39PM +0200, Adrian Bunk wrote:

 > > So put && !4KSTACKS in the XFS configuration ?
 > I originally did this additionally (including moving 4KSTACKS
 > above  XFS).
 > 
 > But independent of the XFS problem, 4kb stacks currently risk additional 
 > breakage without real benefits for most users.

Just before the Fedora kernel got 4K stacks (which was before mainline),
in stress testing, I was hitting memory allocation bugs far sooner than
I was hitting stack overflows, so I don't think this claim has any bearing on reality.
It was far more commonplace for the kernel to struggle to find a free pair
of contiguous pages under extreme load.  And as already mentioned,
those overflows _can_ be hit with an 8KB stack too, you just have to
try harder.

The 'real benefits' you aren't seeing are lots of failing order-1 allocations
under moderate to heavy load. You don't even need big iron boxes to see this,
(in fact, its easier to hit this problem on smaller underpowered boxes).

		Dave


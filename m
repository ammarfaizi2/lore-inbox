Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263635AbUJ2Xnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbUJ2Xnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUJ2XiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:38:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:64401 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263663AbUJ2Xdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:33:52 -0400
Subject: Re: [PATCH] ppc32: Fix boot on PowerMac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041029120331.GE11391@infradead.org>
References: <1099020586.29693.105.camel@gaston>
	 <20041029120331.GE11391@infradead.org>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 09:25:45 +1000
Message-Id: <1099092345.29693.165.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 13:03 +0100, Christoph Hellwig wrote:
> On Fri, Oct 29, 2004 at 01:29:46PM +1000, Benjamin Herrenschmidt wrote:
> > Hi !
> > 
> > Tom's recent irq patch broke PowerMac (and possibly others). I think
> > he forgot that PReP, CHRP and PowerMac are all built together in a
> > single kernel image, thus all of those arch_initcall's will end up
> > beeing called, even on the wrong machine...
> 
> Better rewvert Tom's fix and switch all these early calls to setup_irq,
> like I did for pmac and a few other subarches (I missed the ones Tom
> fixed, sorry)

Patch welcome :)

Ben.



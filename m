Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUJ2MJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUJ2MJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 08:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbUJ2MJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 08:09:50 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:47876 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263295AbUJ2MDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 08:03:37 -0400
Date: Fri, 29 Oct 2004 13:03:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32: Fix boot on PowerMac
Message-ID: <20041029120331.GE11391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1099020586.29693.105.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099020586.29693.105.camel@gaston>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:29:46PM +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> Tom's recent irq patch broke PowerMac (and possibly others). I think
> he forgot that PReP, CHRP and PowerMac are all built together in a
> single kernel image, thus all of those arch_initcall's will end up
> beeing called, even on the wrong machine...

Better rewvert Tom's fix and switch all these early calls to setup_irq,
like I did for pmac and a few other subarches (I missed the ones Tom
fixed, sorry)


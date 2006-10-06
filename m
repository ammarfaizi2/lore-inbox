Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWJFKEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWJFKEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 06:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWJFKEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 06:04:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:44961 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932169AbWJFKEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 06:04:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=R/EuYeXSJTW+N+eHUYzegqDJ2sP0j7gQoMvYFVv7vu5/6QJeVl2D4j2PR44YSX6RyM+dNUg65xSCDvaX12qVd0ybVq8zT6r+vjn1teuEuDM8Wp0+/vdoEisRX8yrHzqb3YCpPD9iXmuHl2Fd99w06i9tiM0/V3JIRJayYWEhRA8=
Date: Fri, 6 Oct 2006 14:04:21 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Matthew Wilcox <matthew@wil.cx>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #3
Message-ID: <20061006100421.GA5335@martell.zuzino.mipt.ru>
References: <20061004193229.GA352@slug> <4524106C.8010807@garzik.org> <20061004202938.GF352@slug> <20061004203311.GI28596@parisc-linux.org> <20061004212633.GG352@slug> <20061005135924.GB5335@martell.zuzino.mipt.ru> <20061005143607.GH352@slug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005143607.GH352@slug>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 02:36:07PM +0000, Frederik Deweerdt wrote:
> > > - is_irq_valid() called by pci_request_irq()
> >
> > s/is_irq_valid/valid_irq/g methinks.
> The point of the is_ prefix is to make it clear that we're returning 1
> if it's true and 0 if it's false.
> <checks thread on return values>
> err... you said[1]:
> > There are at least 3 idioms:
> > [...]
> > 2) return 1 on YES, 0 on NO.
> > [...]
> > #2 should only be used if condition in question is spelled nice:
> Which I thought made sense, and that's why the is_ prefix is there now.
> Am I missing something?

I think, looking at

	if (irq_valid(irq))

one can be damn sure it follows common convention.

That "is_" prefix just beats my ears. If is irq valid.


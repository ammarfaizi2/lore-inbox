Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWJFKbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWJFKbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 06:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWJFKbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 06:31:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:65150 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751412AbWJFKbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 06:31:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=JNFGOq8qCr+vSkxiv0u+qNFIfFlp4Y/7j0gBZxOI69qCE6xz6LW/UHd7k/8QtY4YWoGDojxox2Z7XatYSeKNpSORW2/PGNUJpGOaejn7XBhrOjOB0MI6eKE/36BhBDJQsajuALcVTYs2pu+kufDc6wIzMugdK53q4mliYV84N3o=
Date: Fri, 6 Oct 2006 10:31:27 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #3
Message-ID: <20061006103127.GJ352@slug>
References: <20061004193229.GA352@slug> <4524106C.8010807@garzik.org> <20061004202938.GF352@slug> <20061004203311.GI28596@parisc-linux.org> <20061004212633.GG352@slug> <20061005135924.GB5335@martell.zuzino.mipt.ru> <20061005143607.GH352@slug> <20061006100421.GA5335@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006100421.GA5335@martell.zuzino.mipt.ru>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 02:04:21PM +0400, Alexey Dobriyan wrote:
> On Thu, Oct 05, 2006 at 02:36:07PM +0000, Frederik Deweerdt wrote:
> > > > - is_irq_valid() called by pci_request_irq()
> > >
> > > s/is_irq_valid/valid_irq/g methinks.
> > The point of the is_ prefix is to make it clear that we're returning 1
> > if it's true and 0 if it's false.
> > <checks thread on return values>
> > err... you said[1]:
> > > There are at least 3 idioms:
> > > [...]
> > > 2) return 1 on YES, 0 on NO.
> > > [...]
> > > #2 should only be used if condition in question is spelled nice:
> > Which I thought made sense, and that's why the is_ prefix is there now.
> > Am I missing something?
> 
> I think, looking at
> 
> 	if (irq_valid(irq))
> 
> one can be damn sure it follows common convention.
That maybe true, however the is_ prefix just rules out any ambiguity.
Using is/has/have/can for boolean functions whenever possible is a good
practice and I'd prefer to stick to it.
> That "is_" prefix just beats my ears. If is irq valid.
I understand your concerns on the "sound" issues though. Does
is_valid_irq() sound better to you?

Thanks,
Frederik

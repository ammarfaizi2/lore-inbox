Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWJ1QrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWJ1QrE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 12:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWJ1QrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 12:47:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46721 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751058AbWJ1QrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 12:47:02 -0400
Date: Sat, 28 Oct 2006 17:46:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Stephane Eranian <eranian@hpl.hp.com>,
       sam@ravnborg.org
Subject: Re: [PATCH] rename net_random to random32
Message-ID: <20061028164652.GA22673@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>,
	Stephen Hemminger <shemminger@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@hpl.hp.com>, sam@ravnborg.org
References: <200610111900.k9BJ01M4021853@hera.kernel.org> <452D4491.30806@garzik.org> <20061011122938.7e81f4bc@freekitty> <20061012000749.be62f2e0.akpm@osdl.org> <20061012102638.7381269a@freekitty> <20061013181922.GB721@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013181922.GB721@stusta.de>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 08:19:22PM +0200, Adrian Bunk wrote:
> > --- /dev/null
> > +++ b/lib/random32.c
> >...
> > +EXPORT_SYMBOL(random32);
> >...
> > +EXPORT_SYMBOL(srandom32);
> >...
> 
> EXPORT_SYMBOL's in lib-y are latent bugs (IMHO kbuild should error
> on them):
> 
> The problem is that if only modules use these functions, they will be 
> omitted from the kernel image.

In fact we should really really just kill lib-y completely.  Leaving
the control of what gets built in to the linker shound like a really
bad idea in our enviroment.

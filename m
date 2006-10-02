Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965351AbWJBTF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965351AbWJBTF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965353AbWJBTF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:05:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:65056 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965350AbWJBTFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:05:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=MKUP01pM6t+h0cFHr4s45BV4kEyZ3juTcrh0/2O540qBmW89WVPTuNELGpGUVH+LZbO6HJtVce/L8/P9D6B5Jqva5AvVnNr7E9xRzdfuGnXffPTcDLMT/yh4smn5rh11x9GPOFsePqwk5KhcF5XWZay82cKw+OY2hEcVGFYUSRE=
Date: Mon, 2 Oct 2006 21:04:29 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] move tg3 to pci_request_irq
Message-ID: <20061002210429.GH3003@slug>
References: <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug> <20061002201134.GE3003@slug> <20061002182847.GN16272@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002182847.GN16272@parisc-linux.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 12:28:47PM -0600, Matthew Wilcox wrote:
> On Mon, Oct 02, 2006 at 08:11:34PM +0000, Frederik Deweerdt wrote:
> > @@ -6838,9 +6838,9 @@ restart_timer:
> >  
> >  static int tg3_request_irq(struct tg3 *tp)
> >  {
> > +	struct net_device *dev = tp->dev;
> >  	irqreturn_t (*fn)(int, void *, struct pt_regs *);
> >  	unsigned long flags;
> > -	struct net_device *dev = tp->dev;
> >  
> >  	if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
> >  		fn = tg3_msi;
> 
> Is there any reason for this noise?
You mean, besides my awkwardness ? ;)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

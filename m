Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWJBU1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWJBU1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWJBU1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:27:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:45089 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964992AbWJBU1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:27:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=hht+Tk41FGVz73LOTM6NWoNct05V2QdWFPRwZlJnFA31EYN6qelCNCEy2asyLibA04vGmVPNh+MPW7jk4ajzICMx6jMdqTN+O7QLRpzLClAliAzZREP7qBABweJxAqYGrgWChPs6MiJX3DmEAH2LRFw8pZoDZMkRw7VMn3q2X5A=
Date: Mon, 2 Oct 2006 22:26:25 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] move drm to pci_request_irq
Message-ID: <20061002222625.GK3003@slug>
References: <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug> <20061002201229.GF3003@slug> <1159821398.8907.57.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159821398.8907.57.camel@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 09:36:38PM +0100, Alan Cox wrote:
> Ar Llu, 2006-10-02 am 20:12 +0000, ysgrifennodd Frederik Deweerdt:
> > Hi,
> > 
> > This proof-of-concept patch converts the drm driver to use the
> > pci_request_irq() function.
> 
> 0 isn't invalid - it means no IRQ was assigned so wants a different
> message.
> 
I understand, what about:

("No usable irq line was found (got #%d)\n", irqno)

This is generic enough, so that if on some arches a given irq (other
than 0) is invalid, the message still makes sense.

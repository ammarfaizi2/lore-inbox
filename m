Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVJQRJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVJQRJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVJQRJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:09:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:22252 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750855AbVJQRJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:09:32 -0400
Date: Mon, 17 Oct 2005 10:08:55 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Kolli, Neela Syam" <Neela.Kolli@engenio.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/2] Convert megaraid to use pci_driver shutdown metho d
Message-ID: <20051017170855.GA1251@kroah.com>
References: <0E3FA95632D6D047BA649F95DAB60E5707232141@exa-atlanta> <20051017134228.GA31938@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017134228.GA31938@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 02:42:28PM +0100, Christoph Hellwig wrote:
> On Mon, Oct 17, 2005 at 09:26:12AM -0400, Kolli, Neela Syam wrote:
> > Patch looks good.  Thanks for the patch.
> 
> another 2.6.14 candidate, without it we'd easily get corruption
> on shutdown when the root filesystem is on megaraid.

No, the megaraid shutdown method will be called, only if that member
isn't set will the pci shutdown call be made.  So this should be safe
today, right?

thanks,

greg k-h

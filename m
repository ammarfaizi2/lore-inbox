Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVIPVqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVIPVqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVIPVql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:46:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751309AbVIPVql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:46:41 -0400
Date: Fri, 16 Sep 2005 23:46:32 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mmap(2)ping of pci_alloc_consistent() allocated buffers on 2.4 kernels question/help
Message-ID: <20050916214632.GA13136@devserv.devel.redhat.com>
References: <Pine.LNX.4.60.0509162009510.14084@kepler.fjfi.cvut.cz> <1126896652.3103.10.camel@localhost.localdomain> <Pine.LNX.4.60.0509162302310.14757@kepler.fjfi.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0509162302310.14757@kepler.fjfi.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Sep 16, 2005 at 11:24:08PM +0200, Martin Drab wrote:
> 
> And would that help anyhow?

yes it would

> (obtained via the RT FIFO) that he wants to mmap, the ioctl mmaps it to 
> the app., app. uses the data, and then calls another ioctl to unmap the 
> buffer and release it for next filling.

don't use ioctls for this; the driver can just provide an mmap method and
you can map this pci alloc'd ram straight into the userspace app... 


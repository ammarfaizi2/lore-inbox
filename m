Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269146AbUINDgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269146AbUINDgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUINDgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:36:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:55478 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269146AbUINDgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:36:23 -0400
Date: Mon, 13 Sep 2004 20:35:49 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>, ink@jurassic.park.msu.ru,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [RFT 2.6.9-rc1 alpha sys_alcor.c] [1/2] convert pci_find_device to pci_get_device
Message-ID: <20040914033549.GA13146@kroah.com>
References: <806400000.1095118633@w-hlinder.beaverton.ibm.com> <20040914020116.GA23058@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914020116.GA23058@twiddle.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 07:01:16PM -0700, Richard Henderson wrote:
> On Mon, Sep 13, 2004 at 04:37:13PM -0700, Hanna Linder wrote:
> > Here is a very simple patch to convert pci_find_device call to pci_get_device.
> > As I don't have an alpha box or cross compiler could someone (wli- wink wink)
> > please verify it compiles and doesn't break anything, thanks a lot.
> 
> Presumably the intent is to eventually remove pci_find_device?

That is the intent.

> These routines run at the very beginning of bootup; there cannot
> possibly be any races.

I agree there isn't any races here, we just need to get rid of
pci_find_device() as people use it in an unsafe manner in lots of
different places.

thanks,

greg k-h

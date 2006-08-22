Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWHVO6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWHVO6d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWHVO6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:58:33 -0400
Received: from smtp-out.google.com ([216.239.45.12]:7149 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932157AbWHVO6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:58:32 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:references:
	mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
	b=eCYbZfXfbQrCwZerd0d0eTaM8iDqKIKSLIeSatcII203ALHDKNloQ9tDTkf7POQZ9
	hVNKoW+H3K0bK6PdndBbA==
Date: Tue, 22 Aug 2006 07:58:02 -0700
From: Tim Hockin <thockin@google.com>
To: Andi Kleen <ak@suse.de>
Cc: matthew@wil.cx, greg@kroah.com,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@google.com>
Subject: Re: PCI MMCONFIG aperture size
Message-ID: <20060822145802.GR16573@google.com>
References: <20060822024237.GO16573@google.com> <200608220955.31620.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608220955.31620.ak@suse.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 09:55:31AM +0200, Andi Kleen wrote:
> 
> > This says to me that (as long as the MCFG table has an End Bus Number of
> > 31) a 32 MB decode area (32 MB aligned, too) is valid.
> > 
> > Would something like the below patch be accepted?  It makes my system
> > work...
> 
> I already got a patch to remove the complete e820 validation code because
> it broke far more than it fixed. That should fix your problem too.

Great!  Coming in 2.6.18?

> > Also, why are we forcing 32 bit base addresses?  ACPI defines it to be a
> > 64 bit base...
> 
> Where do you think we do that?

Looking at 2.6.17, we always have u32 base_address and u32
base_reserved.  base_address is the only one ever referenced, that I can
see.  I guess I should grab 2.6.18 pre-releases and recheck.

Thanks

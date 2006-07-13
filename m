Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWGMQhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWGMQhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWGMQhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:37:55 -0400
Received: from mx.pathscale.com ([64.160.42.68]:50661 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030204AbWGMQhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:37:54 -0400
Subject: Re: Suggestions for how to remove bus_to_virt()
From: Ralph Campbell <ralphc@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: David Miller <davem@davemloft.net>, rolandd@cisco.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <adaodvttrvc.fsf@cisco.com>
References: <1152746967.4572.263.camel@brick.pathscale.com>
	 <adar70quzwx.fsf@cisco.com> <20060712.174013.95062313.davem@davemloft.net>
	 <adaodvttrvc.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 09:37:54 -0700
Message-Id: <1152808674.4572.282.camel@brick.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all for the pointers and suggestions.
It will probably take me a while to follow up on these
and make another proposal.

On Thu, 2006-07-13 at 09:02 -0700, Roland Dreier wrote:
>  > > A cleaner solution would be to make the dma_ API really use the device
>  > > it's passed anyway, and allow drivers to override the standard PCI
>  > > stuff nicely.  But that would be major surgery, I guess.
> 
>  > Clean but expensive, you should not force the rest of the kernel
>  > to eat the cost of something you want to do when it's totally
>  > unnecessary for most other users.
> 
> OK, fair enough.
> 
>  > For example, x86 never needs to do anything other than a direct
>  > virt_to_phys translation to produce a DMA address, no matter what
>  > bus the device is on.  It's a single simple integer adjustment
>  > that can be done inline in about 2 or 3 instructions at most.
> 
> <pedantic>Except x86 needs to handle systems with IOMMUs now...</pedantic>
> 
>  > If you need device level DMA mapping semantics, create them for your
>  > device type.  This is what USB does, btw.
> 
> Makes sense -- Ralph, I would suggest looking at USB as a model.
> 
>  - R.


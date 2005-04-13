Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVDMNet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVDMNet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 09:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVDMNet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 09:34:49 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:56610 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261350AbVDMNek convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 09:34:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IgqsSnakSF87vi1CRN2cb2QOpm9i33CfLHuZvxykBvns3knE3jlqxwEmcb4YXVTMbAOWDuNZ/GtTAT8gpqfxDvFyuOcO6HVmrRWVdhP6cTv8pBnHmEnzLfni0Voh+hJv0sp3386zV5ZlMpfXXXqa1IdR/xR16JDvX3APb9JmZQc=
Message-ID: <21d7e997050413063441d83f49@mail.gmail.com>
Date: Wed, 13 Apr 2005 23:34:39 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Yuri Vilmanis <vilmanis@internode.on.net>
Subject: Re: EXPORT_SYMBOL_GPL for __symbol_get replacing EXPORT_SYMBOL for deprecated inter_module_get
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200504131855.00806.vilmanis@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504131855.00806.vilmanis@internode.on.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The case in point for me is ATI's binary openGL accelerated drivers (fglrx) -
> these used inter_module_get() to communicate with the agp gart module, for
> obvious reasons - this AGP communication is essential to the functionality of
> the driver. No, I don't like ATI only having closed-source drivers any more
> than you, but given the extremely competetive nature of high end video card
> sales, I can see why they want to do it this way. The point is that now, as
> of 2.6.11-? or 2.6.12-? (not sure of the exact revision), the
> inter_module_get() functions has been removed, and the functionality can only
> be got (as far as I can tell) through use of the symbol_get() function.
> 

you might have done some research on what happened before ranting away
like a crazy.....

AGP dropped the drm_agp interface in favour of the DRM modules calling
the AGP backend directly, a patch for the ATI drivers has been sailing
around for ages I even wrote one myself for someone I think but I've
lost it now ... all the AGP symbols needed are exported with
EXPORT_SYMBOL.

you might have noticed no-one else complaining around here which is
usually a good sign that there is nothing worth complaining about :-)

Dave.

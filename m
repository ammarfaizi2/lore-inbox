Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVGFPnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVGFPnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 11:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVGFPnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 11:43:24 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:9002 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262218AbVGFLPY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 07:15:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RxW1OtKkJycNuE3og8cYRTcxFOplgqHEc4UhIl0lKvNWjvaYHdXe2VOcyxodQ4bYRm52EOOWzn1+a0sil2AO+WQf4asyr/PD5Bf+ZVGodYRx2oz7MBDKTiyzoWlPDVWYd0YUK+Wbk/Ilr9/N9CgUZrtCn2Wmo7eZmENDEeayt+8=
Message-ID: <21d7e99705070604153270c475@mail.gmail.com>
Date: Wed, 6 Jul 2005 21:15:21 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] drm: remove drm_calloc()
Cc: Alexey Dobriyan <adobriyan@gmail.com>, David Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1120461167.3174.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507041026.52631.adobriyan@gmail.com>
	 <21d7e99705070323334a194b47@mail.gmail.com>
	 <1120461167.3174.0.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The DRM has wrappers for these function due to it being used on other
> > OS'es (BSD mainly)
> 
> yes and? how about naming that wrapper "kcalloc()" instead.... which
> would make the linux "wrapper" empty and the bsd wrapper just trivial
> las well ?

drm_calloc doesn't have the same interface as kcalloc... it gets
passed an area parameter and we use it on other OSes.. I'm not going
to split Linux and BSD drivers just for a trivial little thing like
this.. I'll fix the wrapper like I said..

Dave.

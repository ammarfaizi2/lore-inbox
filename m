Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUKOVLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUKOVLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUKOVIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:08:55 -0500
Received: from vega.lnet.lut.fi ([157.24.109.150]:64005 "EHLO vega.lnet.lut.fi")
	by vger.kernel.org with ESMTP id S261712AbUKOVHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:07:21 -0500
Date: Mon, 15 Nov 2004 23:07:19 +0200
To: Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-alpha <linux-alpha@vger.kernel.org>
Subject: Re: [alpha] linux-2.6.10-rc1-bk20 compile error
Message-ID: <20041115210719.GC690@vega.lnet.lut.fi>
References: <1100202570.26565.3.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100202570.26565.3.camel@pro30.local.promotion-ie.de>
User-Agent: Mutt/1.3.28i
From: lapinlam@vega.lnet.lut.fi (Tomi Lapinlampi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 08:49:30PM +0100, Alexander Rauth wrote:
> 
> error appears with linux-2.6.10-rc1-bk20:
> 
>   CC      arch/alpha/kernel/setup.o
> arch/alpha/kernel/setup.c: In function `setup_arch':
> arch/alpha/kernel/setup.c:597: warning: implicit declaration of function
> `__sysrq_get_key_op'
> arch/alpha/kernel/setup.c:597: warning: initialization makes pointer
> from integer without a cast
> make[1]: *** [arch/alpha/kernel/setup.o] Error 1
> make: *** [arch/alpha/kernel] Error 2
> 

Hi,

This issue is still present in 2.6.10-rc2.

drivers/char/sysrq.c no longer exports __sysrq_get_key_op which
is required by arch/alpha/kernel/setup.c.

Tomi



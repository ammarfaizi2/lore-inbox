Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVL2Kj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVL2Kj0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 05:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVL2Kj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 05:39:26 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:30920 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932510AbVL2KjZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 05:39:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j3G6jifq4JK7Yz0o4OAqrLoywb2DjzVV1E2OQXvEIPd1YwSnlLajLU7wmNGS340+6tmcSfMBsCZawyqsl/jNuP1EB/zX2uW1tAFYJg1ytKNryBJ5AB1l7FRGd6+8+cD5VG5RGAPIwcyHzhDznYjSBEqHQpyA9lgKHUXvK7I5mR4=
Message-ID: <84144f020512290239t6192b344g63e4a71e44e8dfaa@mail.gmail.com>
Date: Thu, 29 Dec 2005 12:39:23 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] ipw2200 stack reduction
Cc: Zhu Yi <yi.zhu@intel.com>, jketreno@linux.intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051229091940.GD2772@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228212934.GA2772@suse.de>
	 <1135847228.9670.69.camel@debian.sh.intel.com>
	 <20051229091940.GD2772@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/29/05, Jens Axboe <axboe@suse.de> wrote:
> Well you could do that if you wanted, but 500 bytes of dynamic
> allocation is not a big issue. But it could be an optimization on top of
> this patch, indeed. The downside is that you then have to do 2
> allocations for each command, so whether it would be a win or not I
> don't know.

The allocation shouldn't make much difference but for the implicit
memset() smaller size is a win maybe?

                                Pekka

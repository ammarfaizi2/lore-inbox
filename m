Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWJTI4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWJTI4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 04:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWJTI4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 04:56:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:6035 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932211AbWJTI4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 04:56:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OVDS9nz679AGj5WDWatwrOXsLHTHKnbbbnwUki1KS0wB7LiNgBfkvzrFLMQ76irflyIMKlZcJJ5187F6o6m1aSrnjxwpuQdZpPT+FGwl2OsaD9YElgbDM0Pl4lmvEmw3zKOlUUKiJaINYXqyQ48NLO5UxhdwL8eW95GTseEuN7o=
Message-ID: <84144f020610200156t1745b3d6xee0b0a24e6a1bba5@mail.gmail.com>
Date: Fri, 20 Oct 2006 11:56:08 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Kevin Hilman" <khilman@mvista.com>
Subject: Re: [PATCH] slab debug and ARCH_SLAB_MINALIGN don't get along
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11612878321443-git-send-email-khilman@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11612878321443-git-send-email-khilman@mvista.com>
X-Google-Sender-Auth: 1390098e7ac90b17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 10/19/06, Kevin Hilman <khilman@mvista.com> wrote:
> When CONFIG_SLAB_DEBUG is used in combination with ARCH_SLAB_MINALIGN,
> some debug flags should be disabled which depend on BYTES_PER_WORD
> alignment.
>
> The disabling of these debug flags is not properly handled when
> BYTES_PER_WORD < ARCH_SLAB_MEMALIGN < cache_line_size()
>
> This patch fixes that and also adds an alignment check to
> cache_alloc_debugcheck_after() when ARCH_SLAB_MINALIGN is used.

You forgot to mention which case you are fixing in the patch
description (that is, SLAB_HWCACHE_ALIGN, when cache_line_size() >
BYTES_PER_WORD) which made the patch bit hard to decipher. Anyway,
looks good, thanks!

                                              Pekka

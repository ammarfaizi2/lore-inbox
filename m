Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWENOtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWENOtc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 10:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWENOtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 10:49:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:49489 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751431AbWENOtb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 10:49:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=RE2CGWyBGwRYnKINlub8jVItRdCPlG0c7nGIc66p1soAR7gXUlFtJPZ6B6zVCbDMHVeRIl3XQKLxFib/7Q4QrZXVm4uQanLp4gXxrnCUIaZ2ZpR0gakDR9oXzQ65nC1d3MHi2xqr0S27L3ti42Jr2w+vau667T0HTQRYbvNvidM=
Message-ID: <84144f020605140749k5dec66f3gb72cb9a3a2dea510@mail.gmail.com>
Date: Sun, 14 May 2006 17:49:30 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 3/6] Add the memory allocation/freeing hooks for kmemleak
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060513160605.8848.57802.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <20060513160605.8848.57802.stgit@localhost.localdomain>
X-Google-Sender-Auth: 0850a32c73a90fbd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> This patch adds the callbacks to memleak_(alloc|free) functions from
> kmalloc/kree, kmem_cache_(alloc|free), vmalloc/vfree etc.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Way too many #ifdefs. Instead, please make memleak_alloc() and
memleak_free() empty static inline functions for the
non-CONFIG_DEBUG_MEMLEAK case.

                                                        Pekka

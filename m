Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVHQFKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVHQFKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVHQFKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:10:39 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:33548 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750829AbVHQFKi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:10:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=seBXNOC0EGNDmaICPmSkbqXZGV2xYMkZy//DGgVtKffgWye74iVpP/7Yo3nOX/jnMrs3w2bz3e+bKkK6hIVA/eMh69kqeNK7DErykvlAKWHpBUvUSB3bvU/DibzdSCHtRHy5luRTmcXwy3o+JJ0gWjkDv6XuiXNcEhJVD/t/8MA=
Message-ID: <98df96d305081622107ca969f@mail.gmail.com>
Date: Wed, 17 Aug 2005 14:10:34 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Akira Tsukamoto <akira-t@s9.dion.ne.jp>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050817.110503.97359275.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <98df96d3050815163331d6cce1@mail.gmail.com>
	 <20050816.123042.424254477.hyoshiok@miraclelinux.com>
	 <1124171390.3215.8.camel@laptopd505.fenrus.org>
	 <20050817.110503.97359275.taka@valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akira,

Thanks for your suggestions.

On 8/17/05, Akira Tsukamoto <akira-t@s9.dion.ne.jp> wrote:
> Anyway, going back to copy_user topic,
> big remaining issues are
>   1)store/restore floating point register (80/64bytes) twice every time by
>      surrounding with kernel_fpu_begin()/kernel_fpu_end() is big penalty

I don't know. If nobody uses MMX/XMM, then there is no need
to save and restore.

>   2)after pagefault not always come back to copy function and corrupts fp register

I'm trying to understand this mechanism but I don't
understand very well.

>   3)disabling long preemption
> Please correct me if I am wrong.
> 
> I tried to implement fpsave inside pagefault handler once and here is my junk;
> http://www.suna-asobi.com/~akira-t/linux/k7-copy-user/K7-copy_47_with_fpusave_not_finished.patch
> never had a time to finish it. Hiro, does it help you?

Thanks. I'm reading your patch but could not understand very well.

I'll ask you.

Regards,
  Hiro
-- 
Hiro Yoshioka
mailto:hyoshiok at miraclelinux.com

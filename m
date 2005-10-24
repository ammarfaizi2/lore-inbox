Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVJXJeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVJXJeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 05:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVJXJeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 05:34:17 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:49598 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750820AbVJXJeR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 05:34:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JHKJrkkInhmMnKDquqsBI//csFaMnHflSSOV8Ij667pOA5sKQRQWCddghA+XCAbsEO9OL1ho46Z/voKnZQDQ92n9rAmthYCk52wM7uBUUFgDcGPC3WpeJAZjz57yncMJXR6mJ/SuIxqwP4DZ3ZVuOK9COM+jtwTG5LG5jA7uNwo=
Message-ID: <40f323d00510240234s262a763h916b27d36b4fadad@mail.gmail.com>
Date: Mon, 24 Oct 2005 11:34:15 +0200
From: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc5-mm1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051024014838.0dd491bb.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/05, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/
>
>
> +x86-inline-spin_unlock-if-not-config_debug_spinlock-and-not-config_preempt.patch
> +x86-inline-spin_unlock_irq-if-not-config_debug_spinlock-and-not-config_preempt.patch
>
>  x86 tweaks
>

those two breaks on UP since the lock can be NULL and it deferences it.

regards,

Benoit

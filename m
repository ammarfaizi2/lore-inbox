Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVAMLqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVAMLqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVAMLqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:46:34 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:21734 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261586AbVAMLqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 06:46:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=M7WZYgC5yT2QsvOJvDJfmdWjC1XSuhOUDbidJ8cB2YeK3HFHL7L3dbieY3NZG9VCYM1h5n2LRcvhQ50Vaiat09HYFQEwkZ9FHmZzPA6SqayD4Dc0D8dHnSZM1lGuszXiCf19EDdYClFnaCs3/dINDGH1CccQqJrU0d74Kv8+Q58=
Message-ID: <5b64f7f050113034640e28eb9@mail.gmail.com>
Date: Thu, 13 Jan 2005 06:46:32 -0500
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: Andrew Walrond <andrew@walrond.org>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Cc: Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <200501131100.19500.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501081613.27460.mmazur@kernel.pl>
	 <200501130813.42545.andrew@walrond.org>
	 <200501131042.25470.mmazur@kernel.pl>
	 <200501131100.19500.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 11:00:19 +0000, Andrew Walrond <andrew@walrond.org> wrote:
> On Thursday 13 January 2005 09:42, Mariusz Mazur wrote:
> >
> > I'm a distribution vendor. If x11 really required having current kernel
> > config at compile time to function properly, I'd start sending threats to
> > its authors.

We are not talking about an application, but rather out of tree kernel
modules (or rather, different versions of modules already in the
tree).
 
> Well there is certainly stuff like
> 
>  ifdef ARCHX86
>   ifndef CONFIG_X86_CMPXCHG
>    $(error CONFIG_X86_CMPXCHG needs to be enabled in the kernel)
>   endif
>  endif
> 
>  and
> 
>  ifdef CONFIG_AGP
>   ifneq (,$(findstring mga,$(DRM_MODULES)))
>    CONFIG_DRM_MGA := m
>   endif
>  endif

Let's be clear here: these are not regular X11 files, but those meant
to compile kernel modules. Are you surprised that config.h is needed?

-Rahul

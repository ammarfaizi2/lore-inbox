Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264978AbSJWNZt>; Wed, 23 Oct 2002 09:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264979AbSJWNZt>; Wed, 23 Oct 2002 09:25:49 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:58814 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264978AbSJWNZt>; Wed, 23 Oct 2002 09:25:49 -0400
Subject: Re: [PATCH] use 1ULL instead of 1UL in kernel/signal.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com
In-Reply-To: <20021023141712.M27461@parcelfarce.linux.theplanet.co.uk>
References: <20021022222719.H27461@parcelfarce.linux.theplanet.co.uk>
	<1035323879.329.185.camel@irongate.swansea.linux.org.uk>
	<20021022224853.I27461@parcelfarce.linux.theplanet.co.uk>
	<1035328632.329.187.camel@irongate.swansea.linux.org.uk> 
	<20021023141712.M27461@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 14:48:31 +0100
Message-Id: <1035380911.3968.56.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 14:17, Matthew Wilcox wrote:
> +#if SIGRTMIN > 32
> +#define M(sig) (1ULL << (sig))
> +#else
>  #define M(sig) (1UL << (sig))
> +#endif

Not >= ??


otherwise it looks very sensible


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267952AbTCFPrR>; Thu, 6 Mar 2003 10:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268045AbTCFPrR>; Thu, 6 Mar 2003 10:47:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37036 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267952AbTCFPrR>;
	Thu, 6 Mar 2003 10:47:17 -0500
Message-ID: <3E676FE7.4010204@pobox.com>
Date: Thu, 06 Mar 2003 10:57:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] work around gcc-3.x inlining bugs
References: <20030306032208.03f1b5e2.akpm@digeo.com>
In-Reply-To: <20030306032208.03f1b5e2.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> This patch:
> 
> --- 25/include/linux/compiler.h~gcc3-inline-fix	2003-03-06 03:02:43.000000000 -0800
> +++ 25-akpm/include/linux/compiler.h	2003-03-06 03:11:42.000000000 -0800
> @@ -1,6 +1,11 @@
>  #ifndef __LINUX_COMPILER_H
>  #define __LINUX_COMPILER_H
>  
> +#if __GNUC__ >= 3
> +#define inline __inline__ __attribute__((always_inline))
> +#define __inline__ __inline__ __attribute__((always_inline))
> +#endif


I think there is also either __inline or inline__?


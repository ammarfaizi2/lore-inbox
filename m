Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313596AbSDPEsk>; Tue, 16 Apr 2002 00:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313598AbSDPEsj>; Tue, 16 Apr 2002 00:48:39 -0400
Received: from zero.tech9.net ([209.61.188.187]:37124 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313596AbSDPEsi>;
	Tue, 16 Apr 2002 00:48:38 -0400
Subject: Re: [Patch] Compilation error on 2.5.8
From: Robert Love <rml@tech9.net>
To: Bongani <bonganilinux@mweb.co.za>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1018933094.2688.443.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 00:48:39 -0400
Message-Id: <1018932520.3331.54.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-16 at 00:57, Bongani wrote:
> Ok, so this patch should be fine then

I likee.

> --- init/main.c Tue Apr 16 06:52:20 2002
> +++ init/main.c_new     Tue Apr 16 06:55:17 2002
> @@ -272,6 +272,10 @@
>  #define smp_init()     do { } while (0)
>  #endif
> 
> +static inline void setup_per_cpu_areas(void)
> +{
> +}
> +
>  #else
> 
>  #ifdef __GENERIC_PER_CPU
> @@ -297,9 +301,11 @@
>         }
>  }
>  #else
> +
>  static inline void setup_per_cpu_areas(void)
>  {
>  }
> +
>  #endif /* !__GENERIC_PER_CPU */
> 
>  /* Called by boot processor to activate the rest. */

	Robert Love


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319436AbSIGBYK>; Fri, 6 Sep 2002 21:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319437AbSIGBYK>; Fri, 6 Sep 2002 21:24:10 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:40718 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319436AbSIGBYK>; Fri, 6 Sep 2002 21:24:10 -0400
Date: Sat, 7 Sep 2002 02:28:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] 1/8 LTT for 2.5.33: Core infrastructure
Message-ID: <20020907022848.A25996@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>
References: <3D792919.C40A2F02@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D792919.C40A2F02@opersys.com>; from karim@opersys.com on Fri, Sep 06, 2002 at 06:15:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 06:15:53PM -0400, Karim Yaghmour wrote:
> +endif
> +
> +ifdef CONFIG_TRACE
> +obj-y += trace.o
>  endif

Please try to understand 2.4/2.5-style Makefile first.

>  
> +/* Structure packing within the trace */
> +#if LTT_UNPACKED_STRUCTS
> +#define LTT_PACKED_STRUCT
> +#else				/* if LTT_UNPACKED_STRUCTS */
> +#define LTT_PACKED_STRUCT __attribute__ ((packed))
> +#endif				/* if LTT_UNPACKED_STRUCTS */

I can't see anything defining LTT_UNPACKED_STRUCTS in this patch.

> +int unregister_tracer
> + (tracer_call /* The tracer function */ );

Did you ever read Documentation/CodingStyle?

It would be helpful if you explain what exactly this patch doesm btw.
It's not really obvious from the the patch.

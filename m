Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130191AbQJaGCz>; Tue, 31 Oct 2000 01:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130267AbQJaGCo>; Tue, 31 Oct 2000 01:02:44 -0500
Received: from newton.hartwick.edu ([147.205.85.10]:36114 "EHLO
	newton.hartwick.edu") by vger.kernel.org with ESMTP
	id <S130191AbQJaGCh>; Tue, 31 Oct 2000 01:02:37 -0500
Date: Tue, 31 Oct 2000 01:02:31 -0500
From: Decklin Foster <decklin@red-bean.com>
To: linux-kernel@vger.kernel.org
Subject: Re: test10-pre7 compile error in ip_forward.c
Message-ID: <20001031010231.A11938@gyah.this.is.broken>
In-Reply-To: <20001030222644.A9869@gyah.this.is.broken> <200010310406.UAA05413@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200010310406.UAA05413@pizda.ninka.net>; from davem@redhat.com on Mon, Oct 30, 2000 at 08:06:59PM -0800
X-PGP-Key: 0xF1968D1B at keyring.debian.org
Organization: Imperial Mica Board
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> Sorry.  Please try this patch below.  Linus, please apply:

This fixes it -- thanks.

> --- include/linux/netdevice.h.~1~	Mon Oct 30 17:57:20 2000
> +++ include/linux/netdevice.h	Mon Oct 30 20:05:38 2000
> @@ -55,6 +55,7 @@
>  #define NET_RX_CN_MOD		2   /* Storm on its way! */
>  #define NET_RX_CN_HIGH		5   /* The storm is here */
>  #define NET_RX_DROP		-1  /* packet dropped */
> +#define NET_RX_BAD		-2  /* packet dropped due to kernel error */
>  
>  #define net_xmit_errno(e)	((e) != NET_XMIT_CN ? -ENOBUFS : 0)

-- 
There is no TRUTH. There is no REALITY. There is no CONSISTENCY. There
are no ABSOLUTE STATEMENTS. I'm very probably wrong. -- BSD fortune(6)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

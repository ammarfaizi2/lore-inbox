Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTEOCro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbTEOCro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:47:44 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:12551 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263769AbTEOCrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:47:41 -0400
Date: Thu, 15 May 2003 00:01:47 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, ch@murgatroid.com,
       inaky.perez-gonzalez@intel.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-ID: <20030515030147.GK6372@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>, ch@murgatroid.com,
	inaky.perez-gonzalez@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org
References: <20030514182526.36823e2b.akpm@digeo.com> <Pine.LNX.4.44.0305141827200.28093-100000@home.transmeta.com> <20030514183925.67a538fc.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514183925.67a538fc.akpm@digeo.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 14, 2003 at 06:39:25PM -0700, Andrew Morton escreveu:
> Linus Torvalds <torvalds@transmeta.com> wrote:
> --- 25/init/Kconfig~CONFIG_FUTEX	Wed May 14 12:43:16 2003
> +++ 25-akpm/init/Kconfig	Wed May 14 13:06:15 2003
> @@ -108,8 +108,17 @@ config LOG_BUF_SHIFT
>  		     13 =>  8 KB
>  		     12 =>  4 KB
>  
> +menu "Size reduced kernel"
> +
> +config FUTEX
> +	bool "Futex support"
> +	default y
> +	---help---
> +	Say Y if you want support for Fast Userspace Mutexes (Futexes).
> +	WARNING: disabling futex support will probably cause glibc to fail.
>  endmenu
>  
> +endmenu

Thanks! With this CONFIG_TINY is born :)

- Arnaldo

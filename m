Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVALLMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVALLMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 06:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVALLMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 06:12:15 -0500
Received: from [217.8.180.76] ([217.8.180.76]:53004 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261151AbVALLMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 06:12:09 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Andrew Walrond <andrew@walrond.org>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Date: Wed, 12 Jan 2005 12:11:23 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200501081613.27460.mmazur@kernel.pl> <200501121049.10219.andrew@walrond.org>
In-Reply-To: <200501121049.10219.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200501121211.23475.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ¶roda 12 styczeñ 2005 11:49, Andrew Walrond wrote:
> Upgrading from 2.6.9.1 to 2.6.10.0 causes a mysql build failure on x86:
>
> gcc -DDEFAULT_CHARSET_HOME=\"/pkg/mysql.1\"
> -DDATADIR=\"/pkg/mysql.1/state\" -DSHAREDIR=\"/pkg/mysql.1/share/mysql\"
> -DDONT_USE_RAID -DMYSQL_CLIENT -fPIC -I. -I. -I.. -I../include -O3
> -DDBUG_OFF -march=i686 -O2 -MT password.lo -MD -MP -MF .deps/password.Tpo
> -c password.c  -fPIC -DPIC -o .libs/password.o In file included from
> ../include/my_global.h:291,
>                  from password.c:62:
> /usr/include/asm/atomic.h: In function `atomic_add_return':
> /usr/include/asm/atomic.h:189: error: `boot_cpu_data' undeclared (first use
> in this function)
>
> It builds fine on x86_64 though. I don't know where the fault lies here;
> mysql, libc-headers or linux-2.6.10, so this is just a FYI.

Looks like you've linked your kernel's config.h to llh and that causes the 
problem. You shouldn't do that unless you have a specific reason to, 
otherwise you might end up with problems I'm unable to test for (I can't 
check every possible combination of kernel CONFIG_'s).

I'll state that more clearly in the docs.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again

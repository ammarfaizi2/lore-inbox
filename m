Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVBOG2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVBOG2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 01:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVBOG2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 01:28:42 -0500
Received: from mail.renesas.com ([202.234.163.13]:46238 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261641AbVBOG2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 01:28:39 -0500
Date: Tue, 15 Feb 2005 15:28:28 +0900 (JST)
Message-Id: <20050215.152828.596522355.takata.hirokazu@renesas.com>
To: didickman@yahoo.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: asm-m32r/bug.h (was Re: )
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050213082413.65917.qmail@web14525.mail.yahoo.com>
References: <20050213082413.65917.qmail@web14525.mail.yahoo.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is no special reason at this moment.
Please apply this patch.

Thank you.


From: Daniel Dickman <didickman@yahoo.com>
Date: Sun, 13 Feb 2005 00:24:13 -0800 (PST)
> For the m32r architecture, is there a reason not to use the generic bug.h
> definition?
> 
> Signed-off-by: Daniel Dickman <didickman@yahoo.com>
> 
> --- linux-2.6.11-rc4/include/asm-m32r/bug.h     2004-12-24 16:34:01.000000000
> -0500
> +++ linux/include/asm-m32r/bug.h        2005-02-13 03:39:39.775236000 -0500
> @@ -1,22 +1,4 @@
>  #ifndef _M32R_BUG_H
>  #define _M32R_BUG_H
> -
> -#define BUG()  do { \
> -       printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
> -} while (0)
> -
> -#define PAGE_BUG(page) do { BUG(); } while (0)
> -
> -#define BUG_ON(condition) \
> -       do { if (unlikely((condition)!=0)) BUG(); } while(0)
> -
> -#define WARN_ON(condition) do { \
> -       if (unlikely((condition)!=0)) { \
> -               printk("Badness in %s at %s:%d\n", __FUNCTION__, \
> -               __FILE__, __LINE__); \
> -               dump_stack(); \
> -       } \
> -} while (0)
> -
> -#endif /* _M32R_BUG_H */
> -
> +#include <asm-generic/bug.h>
> +#endif
> 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTKGXHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTKGWXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:23:53 -0500
Received: from dclient217-162-71-11.hispeed.ch ([217.162.71.11]:18103 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S264493AbTKGRPd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 12:15:33 -0500
Message-ID: <3FABD32A.9090601@steudten.com>
Date: Fri, 07 Nov 2003 18:15:22 +0100
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: [BUG Missing define] 2.6.0-test 9-bk11: ALPHA:  missing asm/mca.h
References: <3FA02762.2070304@steudten.com> <20031029131132.422cb65a.akpm@osdl.org>
In-Reply-To: <20031029131132.422cb65a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem still there in -bk11. Who can fix this in the kernel
source code?

Andrew Morton wrote:

> Thomas Steudten <alpha@steudten.com> wrote:
> 
>>This problem ist still there in -test9..
>>
>>In file included from drivers/net/3c509.c:77:
>>include/linux/mca.h:15:21: asm/mca.h: No such file or directory
> 
> 
> --- 25/drivers/net/3c509.c~3c509-mca-fix	Wed Oct 29 13:11:02 2003
> +++ 25-akpm/drivers/net/3c509.c	Wed Oct 29 13:11:02 2003
> @@ -74,7 +74,9 @@ static int max_interrupt_work = 10;
>  
>  #include <linux/config.h>
>  #include <linux/module.h>
> +#ifdef CONFIG_MCA
>  #include <linux/mca.h>
> +#endif
>  #include <linux/isapnp.h>
>  #include <linux/string.h>
>  #include <linux/interrupt.h>
> 
> _

-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages
Want to know what S.u.S.E 1995 cdrom-set contains?



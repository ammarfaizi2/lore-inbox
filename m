Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293028AbSBVWcu>; Fri, 22 Feb 2002 17:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293026AbSBVWck>; Fri, 22 Feb 2002 17:32:40 -0500
Received: from ptldme-smtp2.maine.rr.com ([204.210.65.67]:29357 "EHLO
	ptldme-mls2.maine.rr.com") by vger.kernel.org with ESMTP
	id <S293029AbSBVWc3>; Fri, 22 Feb 2002 17:32:29 -0500
Message-ID: <3C76C77B.98EA690F@maine.rr.com>
Date: Fri, 22 Feb 2002 17:34:35 -0500
From: "David B. Stevens" <dsteven3@maine.rr.com>
Organization: Penguin Preservation Society
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-rc2-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Aloni <da-x@gmx.net>
CC: Davide Libenzi <davidel@xmailserver.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: [RFC] [PATCH] C exceptions in kernel
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

Don't let'em get to ya, they are having a time warp problem.

Finally a method of preventing oops'es.

Cheers,
  Dave


Dan Aloni wrote:
> 
> The attached patch implements C exceptions in the kernel, which *don't*
> depend on special support from the compiler. This is a 'request for
> comments'. The patch is very initial, should not be applied.
> 
> I actually got this code to work in the kernel:
> 
>         try {
>                 printk("TEST: before throwing \n");
>                 throw(1000);
>                 printk("TEST: won't run\n");
>         }
>         catch(unsigned long, value) {
>                 printk("TEST: caught: %ld\n", value);
>         } yrt;

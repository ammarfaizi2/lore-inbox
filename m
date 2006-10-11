Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWJKTrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWJKTrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161188AbWJKTrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:47:07 -0400
Received: from xenotime.net ([66.160.160.81]:15242 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161185AbWJKTrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:47:03 -0400
Date: Wed, 11 Oct 2006 12:48:28 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org
Subject: Re: funny looking equation
Message-Id: <20061011124828.46b287e2.rdunlap@xenotime.net>
In-Reply-To: <1160595655.5512.6.camel@localhost.localdomain>
References: <1160595655.5512.6.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 15:40:55 -0400 Steven Rostedt wrote:

> I was just testing some of my parsing code on all the .c and .h files in
> the Linux kernel, and I came up with this little equation:
> 
> from 2.6.18 drivers/atm/eni.c:1272
> 
> 
> ---
>                         int div;
> 
>                         if (!*pcr) *pcr = eni_dev->tx_bw+reserved;
>                         for (*pre = 3; *pre >= 0; (*pre)--)
>                                 if (TS_CLOCK/pre_div[*pre]/64 > -*pcr) break;
>                         if (*pre < 3) (*pre)++; /* else fail later */
>                         div = pre_div[*pre]*-*pcr;
>                                     ^^^^^^^^^^^^^
>     This could really do with some spaces and a couple of parenthesis.
> 
>                         DPRINTK("max div %d\n",div);
>                         *res = (TS_CLOCK+div-1)/div-1;
> ---
> 
> 
> Oh well, this isn't a bug.  Just something that someone might want to
> clean up the next time they touch that code.

and break the if-lines into kernel style.

---
~Randy

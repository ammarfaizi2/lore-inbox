Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288710AbSAKKvf>; Fri, 11 Jan 2002 05:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289132AbSAKKvZ>; Fri, 11 Jan 2002 05:51:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65033 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288710AbSAKKvR>;
	Fri, 11 Jan 2002 05:51:17 -0500
Message-ID: <3C3EC3A2.C9C9D184@mandrakesoft.com>
Date: Fri, 11 Jan 2002 05:51:14 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rainer Keller <Keller@hlrs.de>
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Small optimization for UP in sched and prefetch
In-Reply-To: <3C3EBF76.3AEB82AB@hlrs.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer Keller wrote:
> PS: Because of usage of prefetch in include/linux/list.h, the memory
> prefetch is triggered 137 times on my configuration...

We need to merge in __builtin_prefetch support into the kernel, because
gcc 3.1 recently got support for it.  It would be nice at least for
future prefetch-related patches to perhaps call __builtin_prefetch, and
have the headers substitute a prefetch if the compiler does not support
it.

	Jeff



-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery

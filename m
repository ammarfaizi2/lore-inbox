Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316475AbSE3IV7>; Thu, 30 May 2002 04:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSE3IV6>; Thu, 30 May 2002 04:21:58 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:12798 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316475AbSE3IV5>; Thu, 30 May 2002 04:21:57 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <5A753748.173116C9.000634D3@netscape.net> 
To: gndutm@netscape.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't include headers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 30 May 2002 09:21:57 +0100
Message-ID: <9253.1022746917@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gndutm@netscape.net said:
> I need to write a device driver under linux. I am using slackware
> linux  kernel 2.4.18.  I have problem to include headers, here is some
> of my code:

> #define __KERNEL__ 
> #include <linux/config.h>      (ok) 

> #ifdef CONFIG_MODVERSIONS
> #define MODVERSIONS 
> #include <linux/modversions.h> (ok)
> #endif

No, this is not OK. Add a simple Makefile like the normal kernel ones 
and do something like 
	make -C /lib/modules/`uname -r`/build SUBDIRS=`pwd`

It's the only way to get the correct gcc options &c. 

--
dwmw2



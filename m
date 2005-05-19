Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVESM1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVESM1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVESM1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:27:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41361 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262194AbVESM1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:27:48 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Arjan van de Ven <arjan@infradead.org>
To: linux-os@analogic.com
Cc: Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       "Gilbert, John" <JGG@dolby.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	 <20050518195337.GX5112@stusta.de>
	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	 <20050519112840.GE5112@stusta.de>
	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
Content-Type: text/plain
Date: Thu, 19 May 2005 14:27:34 +0200
Message-Id: <1116505655.6027.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> First off, I think we need a system-call that will return some of
> the information that now comes from headers. PAGE_SIZE comes to
> mind. You need this for mmap() but there doesn't seem to be any
> way to get it. getpagesize() 'C' library just returns something
> it's swiped from kernel headers when the library was compiled.
> There are other things like the following that sometimes need

for getpagesize() I can see the point

> to be known also.
> 
>  	HZ

HZ may not exist. At all; people are trying to remove it. And userspace
has no business knowing about it either.
>  	TASK_SIZE
what for?

>  	SMP
userspace should not care! Any app that looks at this is buggy; remember
the fully preemptable nature of userspace

>  	Number of errno values

why?

>  	Highest ioctl value used

uhh that;s driver dependent.. and what for ?



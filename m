Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbULSW5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbULSW5I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 17:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbULSW5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 17:57:08 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:18528 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261348AbULSW5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 17:57:05 -0500
Message-ID: <41C6073B.6030204@yahoo.com.au>
Date: Mon, 20 Dec 2004 09:56:59 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: lista4@comhem.se
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, mr@ramendik.ru,
       kernel@kolivas.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2>
In-Reply-To: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa wrote:
> Found the first kernel version with the regression. It's linux-2.6.9-rc1
> 

Thanks!

"[PATCH] token based thrashing control" would be a prime suspect.

None of my infamous VM patches (which did cause random problems) had gone
into 2.6.9-rc1. The first ones were in 2.6.9-rc2.

Well, "[PATCH] make shrinker_sem an rwsem" was in -rc1; I guess that would
be worthwhile testing, if only because it touches vmscan.c

It would be nice to find out what is going on before 2.6.10 gets released,
but Mats isn't going to be able to do any more testing for the moment.
Andrew, what should we do?



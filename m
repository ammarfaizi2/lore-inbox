Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbULTIni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbULTIni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbULTIkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:40:46 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:56678 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261458AbULTHpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 02:45:03 -0500
Message-ID: <41C682F1.20200@yahoo.com.au>
Date: Mon, 20 Dec 2004 18:44:49 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lista4@comhem.se, linux-kernel@vger.kernel.org, mr@ramendik.ru,
       kernel@kolivas.org, riel@redhat.com
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1> <20041219231250.457deb12.akpm@osdl.org>
In-Reply-To: <20041219231250.457deb12.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Voluspa <lista4@comhem.se> wrote:
> 
>>Would be nice though if someone else could verify...
> 
> 
> Well I'd love to, but afaik the only workloads which we currently know of
> involve complex userspace apps which I have no experience running.
> 
> Did anyone come up with a simple step-by-step procedure for reproducing the
> problem?  It would be good if someone could do this, because I don't think
> we understand the root cause yet?
> 

I admit to generally being in the same boat as you with respect to
running complex userspace apps.

However, based on this and other scattered reports, I'd say it seems
quite likely that token based thrashing control is the culprit. Based
on the cost/benefit, I wonder if we should disable TBTC by default for
2.6.10, rather than trying to fix it, and try again for 2.6.11?

Rik? Andrew?

Also, it would be nice to have a sysctl to *completely* disable TBTC,
that would make testing easier.

Nick

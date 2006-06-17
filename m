Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWFQGv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWFQGv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 02:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWFQGv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 02:51:29 -0400
Received: from ns1.suse.de ([195.135.220.2]:4292 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750872AbWFQGv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 02:51:28 -0400
From: Andi Kleen <ak@suse.de>
To: Martin Peschke <mp3@de.ibm.com>
Subject: Re: statistics infrastructure (in -mm tree) review
Date: Sat, 17 Jun 2006 08:51:21 +0200
User-Agent: KMail/1.8
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
References: <20060613232131.GA30196@kroah.com> <p73slm8qqe4.fsf@verdi.suse.de> <44909292.2080005@de.ibm.com>
In-Reply-To: <44909292.2080005@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606170851.22197.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> b) Export statistic_add_counter(), statistic_add_histogram() and the like
>     as part of the programming API (maybe in addition to the flexible
>     statistic_add()) for those exploiters that definitively can't effort
>     branching into a function.
>
>     Loss in functionality (exploiting kernel code dictates how users see
> the data), a bit faster than option a).

(b) if anything. But do we really need all these weird options anyways? 
For me it seems you're far overdesigning.

> What do you think? Did I miss an option?

I think your whole approach is about 10x too complicated.
The normal approach in Linux is to start simple and add complexity later as 
needed.
You seem to try to do it the other way around.

-Andi


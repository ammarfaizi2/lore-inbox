Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbULTPJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbULTPJC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbULTPJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:09:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49064 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261518AbULTPIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:08:39 -0500
Date: Mon, 20 Dec 2004 10:08:13 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Zou, Nanhai" <nanhai.zou@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       lista4@comhem.se, linux-kernel@vger.kernel.org, mr@ramendik.ru,
       kernel@kolivas.org
Subject: RE: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013CA31@pdsmsx402.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0412201006590.13935@chimarrao.boston.redhat.com>
References: <894E37DECA393E4D9374E0ACBBE7427013CA31@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Zou, Nanhai wrote:

> With 2.6.9 + vmscan-ignore-swap-token-when-in-trouble.patch
> OOM killer will be invoked around 30 hours.
>
> While 2.6.10-rc3-mm1 seems to be much more stable.
> At least for the test I was running, it bypassed 48 hours test.

That's Marcelo's vm-pageout-throttling.patch, which is one
of the essential ingredients in avoiding false OOM kills.

I'm waiting on some test results for another two patches
that I suspect are also needed ...

-- 
He did not think of himself as a tourist; he was a traveler. The difference is
partly one of time, he would explain. Where as the tourist generally hurries
back home at the end of a few weeks or months, the traveler belonging no more
to one place than to the next, moves slowly, over periods of years, from one
part of the earth to another. Indeed, he would have found it difficult to tell,
among the many places he had lived, precisely where it was he had felt most at
home.  -- Paul Bowles

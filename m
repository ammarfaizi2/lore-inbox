Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbUKUS4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbUKUS4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUKUS4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:56:55 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:58264 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261788AbUKUS4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:56:49 -0500
Message-ID: <41A0E4E9.3040902@colorfullife.com>
Date: Sun, 21 Nov 2004 19:56:41 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Peter T. Breuer" <ptb@it.uc3m.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: can kfree sleep?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

>Just a question: can kfree sleep?
>
>
>  
>
No, it never sleeps. It's safe to call kfree from arbitrary context. The 
only exception is the NMI oopser and similar arch code.

>I believe so, but slab.c does not enlighten me immediately:
>  
>
Yes, the kfree code is quite long - it must check if freeing one object 
created a freeable page and return it to the page allocator. Together 
with lots of caching and debug checks.

--
    Manfred


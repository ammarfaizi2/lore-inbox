Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWH2GdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWH2GdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 02:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWH2GdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 02:33:20 -0400
Received: from picard.linux.it ([213.254.12.146]:52438 "EHLO picard.linux.it")
	by vger.kernel.org with ESMTP id S1751114AbWH2GdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 02:33:19 -0400
Message-ID: <55584.85.47.20.193.1156833198.squirrel@picard.linux.it>
In-Reply-To: <20060828143003.aaae0d7d.akpm@osdl.org>
References: <20060826160922.3324a707.akpm@osdl.org>
    <20060828200716.GA4244@inferi.kami.home>
    <20060828143003.aaae0d7d.akpm@osdl.org>
Date: Tue, 29 Aug 2006 08:33:18 +0200 (CEST)
Subject: Re: divide error: 0000 in fib6_rule_match [Re: 2.6.18-rc4-mm3]
From: "Mattia Dongili" <malattia@linux.it>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Mattia Dongili" <malattia@linux.it>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, netdev@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, August 28, 2006 11:30 pm, Andrew Morton said:
> On Mon, 28 Aug 2006 22:07:16 +0200
> Mattia Dongili <malattia@linux.it> wrote:
[...]
>> it's at fib6_rules.c:132 but since I can't tell why r->fwmask is 0 I'll
>> avoid proposing a wrong patch :)
>
> Oh.  It looks like this has already been fixed:
>
> #ifdef CONFIG_IPV6_ROUTE_FWMARK
>         if ((r->fwmark ^ fl->fl6_fwmark) & r->fwmask)
>                 return 0;
> #endif
>
> there's no divide in there now.

Ok, great, I have a division instead of the bitwise and there in fact.

thanks
-- 
mattia
:wq!



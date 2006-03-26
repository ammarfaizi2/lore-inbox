Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWCZR5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWCZR5q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWCZR5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:57:46 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:56581 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751466AbWCZR5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:57:46 -0500
Message-ID: <4426D609.2050700@argo.co.il>
Date: Sun, 26 Mar 2006 19:57:29 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Kyle Moffett <mrmacman_g4@mac.com>, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
References: <200603141619.36609.mmazur@kernel.pl>	 <200603231811.26546.mmazur@kernel.pl>	 <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>	 <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix>	 <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>	 <20060326065205.d691539c.mrmacman_g4@mac.com>	 <1143376008.3064.0.camel@laptopd505.fenrus.org>	 <F31089B5-0915-439D-B218-009384E2148F@mac.com>	 <4426974D.8040309@argo.co.il>	 <25A7D808-9900-4035-BEB3-A782C5EF8EF4@mac.com>	 <4426CE5F.5070201@argo.co.il> <1143394195.3055.1.camel@laptopd505.fenrus.org>
In-Reply-To: <1143394195.3055.1.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2006 17:57:34.0765 (UTC) FILETIME=[C2DA75D0:01C650FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> struct _LA(whatever) {
>>     int foo;
>>     int bar;
>> };
>>
>> struct _LA(another) {
>>     ...
>> };
>>     
>
> this is a good sign that this is all very over designed :)
>
>   
It's an eyesore, isn't it? :)
> namespace pollution is perhaps evil, but we also should not overreact.
> Especially for struct names. *IF* they are in a "narrow enough" header,
> the user of the header knows what he is doing, and accepts these to be
> in his namespace.
>   
This is true for a small enough application. But things grow, libraries 
are added, and includes keep pulling other includes in. Sooner or later 
you'll have a collision.
> The problem is things like u64 etc that is VERY common in all headers,
> but then again __u64 etc are just fine, history has proven that already.
>   
Agree. But to be on the safe side one can use uint64_t and friends 
(which the kernel can typedef to u64 and first degree relatives)

-- 
error compiling committee.c: too many arguments to function


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967046AbWKVDgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967046AbWKVDgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 22:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967047AbWKVDgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 22:36:24 -0500
Received: from smtp2.mtco.com ([207.179.226.205]:62112 "EHLO smtp2.mtco.com")
	by vger.kernel.org with ESMTP id S967046AbWKVDgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 22:36:23 -0500
Message-ID: <4563C5B1.2040304@billgatliff.com>
Date: Tue, 21 Nov 2006 21:36:17 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <200611202135.39970.david-b@pacbell.net> <20061121060918.GA2033@linux-sh.org> <200611211013.19127.david-b@pacbell.net>
In-Reply-To: <200611211013.19127.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David:

David Brownell wrote:

>I know some folk say they "need" to remux after boot in non-exceptional cases,
>but the ability to do that (or not) really seems like a separate discussion.
>  
>

I don't need to REmux, but I don't want to bother setting up the routing 
manually at all.  I think the GPIO management stuff can do it properly 
on my behalf, given the information we have to acquire to get the GPIO 
API to work in the first place.

Kind of like with request_irq() and enable_irq().  The driver is saying, 
"I don't care what's actually behind this interrupt source X, I just 
want it routed over to me".  If we commit to hiding the muxing behind 
the API, instead of defining a new, parallel API,  we get that kind of 
mentality for GPIO as well.


That's all.  Go forth and code.  :)


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVDELRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVDELRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 07:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVDELRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 07:17:41 -0400
Received: from [195.23.16.24] ([195.23.16.24]:20700 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261293AbVDELRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 07:17:39 -0400
Message-ID: <425273CF.3090807@grupopie.com>
Date: Tue, 05 Apr 2005 12:17:35 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] create a kstrdup library function
References: <42519911.508@grupopie.com> <20050404211531.GH4087@stusta.de>
In-Reply-To: <20050404211531.GH4087@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains a small bug:
> 
> <--  snip  -->
> 
> ...
> WARNING: /lib/modules/2.6.12-rc1-mm4/kernel/net/sunrpc/sunrpc.ko needs 
> unknown symbol kstrdup
> WARNING: /lib/modules/2.6.12-rc1-mm4/kernel/net/ipv6/ipv6.ko needs 
> unknown symbol kstrdup
> WARNING: /lib/modules/2.6.12-rc1-mm4/kernel/drivers/parport/parport.ko 
> needs unknown symbol kstrdup
> WARNING: /lib/modules/2.6.12-rc1-mm4/kernel/drivers/md/dm-mod.ko needs 
> unknown symbol kstrdup
> 
> <--  snip  -->

Damn, I did compile-test this thing, but didn't remember to compile even 
one of these as modules.

Andrew, do you want me to send a new patch with this fixed, so you can 
back out the current one and apply the new one, or can you simply merge 
this one from Adrian?

If I have to send a new patch, I might as well also fix the "int should 
be size_t" thing that Andres Salomon pointed out.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

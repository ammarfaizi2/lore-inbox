Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVKUQQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVKUQQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVKUQQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:16:43 -0500
Received: from port-195-158-168-246.dynamic.qsc.de ([195.158.168.246]:56482
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932358AbVKUQQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:16:42 -0500
Message-ID: <4381F2D2.5000605@trash.net>
Date: Mon, 21 Nov 2005 17:16:18 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Christian <evil@g-house.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] do not select NET_CLS
References: <437BBC59.70301@g-house.de> <20051116235813.GS5735@stusta.de> <20051121155955.GW16060@stusta.de>
In-Reply-To: <20051121155955.GW16060@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 2.6.15-rc changes NET_CLS to being automatically select'ed when needed.
> 
> This patch confuses users since NET_CLS is a bool, and compiling an 
> additional module that select's NET_CLS causes unresolved symbols since 
> it's not user-visible that adding a module changes the kernel image.
> 
> This patch therefore changes NET_CLS back to the 2.6.14 status quo of 
> being an user-visible option.

I disagree with this patch. NET_CLS enables the infrastructure support
for classifiers. Users generally don't care about infrastructure but
directly usable things, so I'd prefer to have it automatically selected. 
And there are lots of other cases where enabling a module causes changes
in the kernel image. Some examples include some of the netfilter stuff,
the IPsec transforms, NET_CLS_ROUTE4, the ieee80211 stuff, and a lot
more.

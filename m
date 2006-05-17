Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWEQHTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWEQHTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWEQHTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:19:07 -0400
Received: from stinky.trash.net ([213.144.137.162]:26245 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932085AbWEQHTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:19:06 -0400
Message-ID: <446ACE67.4030700@trash.net>
Date: Wed, 17 May 2006 09:19:03 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: sfrost@snowman.net, azez@ufomechanic.net, willy@w.ods.org,
       gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
References: <20060515204142.GO7774@kenobi.snowman.net>	<20060515210342.GP7774@kenobi.snowman.net>	<446AC1FB.5070406@trash.net> <20060516.235910.71774114.davem@davemloft.net>
In-Reply-To: <20060516.235910.71774114.davem@davemloft.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Patrick McHardy <kaber@trash.net>
> Date: Wed, 17 May 2006 08:26:03 +0200
> 
>>OK, updated patch attached. The TTL is now always kept up-to-date.
> 
> 
> Looks nice.
> 
> Is there any reasonable reason to allow ip_pkt_list_tot to ever be
> larger than say 255?  If we can accept that limit, we can shrink
> the recent_entry considerably by packing the index and nstamps
> into a single word next to ttl.


My primary goal was full compatibility, I have no idea about real-life
usage though. Maybe Stephen can answer this.

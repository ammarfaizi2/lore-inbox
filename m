Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWEQHTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWEQHTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWEQHTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:19:17 -0400
Received: from stinky.trash.net ([213.144.137.162]:29573 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932463AbWEQHTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:19:16 -0400
Message-ID: <446ACE73.604@trash.net>
Date: Wed, 17 May 2006 09:19:15 +0200
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
References: <20060515204142.GO7774@kenobi.snowman.net>	<20060515210342.GP7774@kenobi.snowman.net>	<446AC1FB.5070406@trash.net> <20060517.000957.45395448.davem@davemloft.net>
In-Reply-To: <20060517.000957.45395448.davem@davemloft.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Patrick McHardy <kaber@trash.net>
> Date: Wed, 17 May 2006 08:26:03 +0200
> 
> 
>>+	if (info->check_set & (IPT_RECENT_SET | IPT_RECENT_REMOVE) &&
>>+	    (info->seconds || info->hit_count))
>>+		return 0;
> 
> 
> I'm feeling particularly dense today... but what is the relative
> precedence of '&' vs '&&'?
> 
> I've been told that if you have to look up C operator precedence,
> don't bother and add parenthesis instead :)


Bitwise AND has precedence, but I have no problems adding an extra
set of parenthesis around it :)

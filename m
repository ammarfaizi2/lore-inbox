Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVGII6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVGII6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 04:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVGII6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 04:58:16 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:14723 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261287AbVGII6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 04:58:15 -0400
Message-ID: <42CF919D.40009@colorfullife.com>
Date: Sat, 09 Jul 2005 10:58:05 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch for slab leak debugging
References: <1120856219.25294.29.camel@localhost.localdomain>	 <20050708165554.4b958087.akpm@osdl.org> <1120898643.1171.4.camel@localhost.localdomain>
In-Reply-To: <1120898643.1171.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:

>Yeah I knew there was one, but I thought that was a standalone patch
>(the one turning all bufctl to unsigned long, turning off irqs and
>printing all slabs_full to console), my intention with this was a
>proper /proc entry, something that could be a simple config option.
>
>  
>
No, I never wrote a proper /proc interface. But I think the bufctl 
approach is the better solution than storing the first 5 entries in the 
slab structure:
What if there is a leak on a cache with more than 5 entries per slab?

--
    Manfred

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbTK0Sz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 13:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbTK0Sz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 13:55:59 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:6290 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264588AbTK0Sz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 13:55:58 -0500
Message-ID: <3FC648B1.1090607@colorfullife.com>
Date: Thu, 27 Nov 2003 19:55:45 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pinotj@club-internet.fr
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
References: <mnet1.1069958559.15912.pinotj@club-internet.fr>
In-Reply-To: <mnet1.1069958559.15912.pinotj@club-internet.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pinotj@club-internet.fr wrote:

>Thanks for your explanation.
>Should I try with L1 and/or L2 cache disable on my computer (I don't know if it's safe) ?
>I trust my hardware but it's better to get some facts.
>
No, it wouldn't help. Something in the kernel randomly corrupts memory. 
I'm certain that it's not slab. I'm also fairly certain that it's not 
the hardware - IBM guys reproduced corruptions on both ppc64 and i386 
systems (bugzilla 1097 and 1497). The corrupted object is the slab 
structure or the bufctl entries - data near the beginning of a page. But 
I have no idea how to pinpoint it.

--
    Manfred


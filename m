Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTIGUga (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 16:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTIGUga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 16:36:30 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:9695 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261353AbTIGUg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 16:36:29 -0400
Message-ID: <3F5B96C3.1060706@colorfullife.com>
Date: Sun, 07 Sep 2003 22:36:19 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org, peter_daum@t-online.de
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian wrote:

>With CONFIG_M686 CONFIG_X86_L1_CACHE_SHIFT was set to 5, but a Pentium 4 
>requires 7.
>  
>
Why requires? On x86, the cpu caches are fully coherent. A too small L1 
cache shift results in false sharing on SMP, but it shouldn't cause the 
described problems.

And obviously: Pentium II cpus have a 32 byte cache line, increasing the 
L1 setting to 128 bytes only helps by chance.

My bet is that someone overwrites critical memory structures, and with 
more padding, the critical stuff is further away.

--
    Manfred



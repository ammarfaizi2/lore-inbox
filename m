Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWA3P5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWA3P5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWA3P5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:57:19 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:4454 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932349AbWA3P5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:57:18 -0500
Message-ID: <43DE37C5.30003@sw.ru>
Date: Mon, 30 Jan 2006 18:59:01 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, olh@suse.de, balbir@in.ibm.com
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060130120318.GB9181@hasse.suse.de> <43DE25F0.6070709@sw.ru> <20060130145859.GG9181@hasse.suse.de>
In-Reply-To: <20060130145859.GG9181@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

>>
>>this is much cleaner now and looks more like my original patch and is 
>>smaller/more beautifull with counters usage. Thanks.
> 
> 
> Yes, it is heavily inspired by you patch.
thanks again. BTW, out of curiosity why do you work on this?

>>However, with counters instead of list it is possible to create a live 
>>lock :( So I'm not sure it is really ok.
> 
> 
> Hmm, I don't really get what you mean with "live lock".
By "live lock" I mean the situation when you are "locked" in 
shrink_dcache_parent() due to wait_on_prunes() always returns 1.
We used shrinker list with a reference to dentry specially to avoid this 
as much as possible. I'm not sure how real such live lock can be 
created, but I can think it over.

>>BTW, what kernel is it for? 2.6.15 or 2.6.16-X?
> 
> 
> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git from
> today.
thanks!

Kirill


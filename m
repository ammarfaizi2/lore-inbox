Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWFLHTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWFLHTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 03:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWFLHTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 03:19:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:4828 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751025AbWFLHTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 03:19:46 -0400
Date: Mon, 12 Jun 2006 09:19:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Robin H. Johnson" <robbat2@gentoo.org>
cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] tmpfs time granularity fix for [acm]time going backwards.
 Also VFS time granularity bug on creat(). (Repost, more content)
In-Reply-To: <20060612051001.GA18634@curie-int.vc.shawcable.net>
Message-ID: <Pine.LNX.4.61.0606120917270.2918@yvahk01.tjqt.qr>
References: <20060611115421.GE26475@curie-int.vc.shawcable.net>
 <Pine.LNX.4.64.0606111833220.15060@blonde.wat.veritas.com>
 <20060612051001.GA18634@curie-int.vc.shawcable.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > After some digging, I found that this was being caused by tmpfs not having a
>> > time granularity set, thus inheriting the default 1s granularity.
>> That's a great little discovery, and a very good report and analysis:
>> thank you.  Seems tmpfs got missed when s_time_gran was added in 2.6.11,
>> and I (tmpfs maintainer) failed to notice that patch going past.
>Ah, ok, it was mentioned to me there was a maintainer for tmpfs,
>
Well I was not for sure there was one. I just repeated what Linus said to 
me a while ago when trying to figure out why a patch did not get 
in or replied to. :p


Jan Engelhardt
-- 

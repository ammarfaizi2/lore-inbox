Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbUKIR0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbUKIR0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 12:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbUKIR0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 12:26:40 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:52608 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261591AbUKIR0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 12:26:30 -0500
From: "Christian Kujau" <evil@g-house.de>
To: Christian Kujau <evil@g-house.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pekka Enberg <penberg@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <greg@kroah.com>
Reply-To: evil@g-house.de
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
Date: Tue, 9 Nov 2004 18:26:23 +0100
Message-Id: <20041109164238.M12639@g-house.de>
In-Reply-To: <4190B910.7000407@g-house.de>
References: <4180F026.9090302@g-house.de>	 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>	 <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de>	 <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>	 <418F6E33.8080808@g-house.de>	 <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>	 <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de>	 <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de>
X-Mailer: Open WebMail 2.41 20040926
X-OriginatingIP: 195.126.66.126 (evil)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2004 13:33:20 +0100, Christian Kujau wrote
> i've disabled *only* CONFIG_PREEMPT in another .config but it 
> still oopses:

at least i finally found the "bad" .config option: it's CONFIG_EDD.
when i disable this option (and only this options. i can use the same
.config as usual only disbaling this very option. diff is my witness.)
i can boot a current (!) 2.6.10-rc1-bk and a working snd-ens1371!

i'll test with CONFIG_EDD=m later on. here a short summary:

2.6.9         CONFIG_EDD=y   - OK
2.6.10-rc1-bk CONFIG_EDD=y   - OOPS!
2.6.10-rc1-bk CONFIG_EDD=n   - OK
2.6.10-rc1-bk CONFIG_EDD=m   - ??

yes, i'll continue to find out the ChangeSet but now i (and perhaps you
too, if you are as curious as me) will know where to look at.
i must admit that i was not entirely sure why i wanted to enable
CONFIG_EDD at all. if i had never enabled it, it'd have saved me a week
of bug chasing, but learning is fun, too.

thanks,
Christian.
-- 
BOFH excuse #209:

Only people with names beginning with 'A' are getting mail this week (a
la Microsoft)

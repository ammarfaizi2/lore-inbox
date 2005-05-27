Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVE0O1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVE0O1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVE0O1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:27:32 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:41381 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261769AbVE0O12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:27:28 -0400
Subject: Re: RT patch acceptance
From: Duncan Sands <baldrick@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <s5hwtpkwz4z.wl@alsa2.suse.de>
References: <20050524192029.2ef75b89.akpm@osdl.org>
	 <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de>
	 <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu>
	 <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu>
	 <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu>
	 <20050527133122.GF86087@muc.de>  <s5hwtpkwz4z.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Fri, 27 May 2005 16:27:24 +0200
Message-Id: <1117204044.23459.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, as Ingo stated many times, addition cond_resched() to
> might_sleep() does achieve the "usable" latencies  -- and obviously
> that's hacky.
> 
> So, the only question is whether changing (inserting) cond_resched()
> to all points would be acceptable even if it results in a big amount
> of changes...

Or change (almost) all calls to might_sleep() into calls to
cond_reched(), and put a might_sleep() inside cond_reched().

Ciao,

D.


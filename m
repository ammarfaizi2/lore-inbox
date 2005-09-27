Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbVI0VsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVI0VsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVI0VsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:48:00 -0400
Received: from ns1.coraid.com ([65.14.39.133]:4160 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S965171AbVI0Vr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:47:58 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/2]: explicitly set minimum packet
 length to ETH_ZLEN
References: <87hdc7ept7.fsf@coraid.com>
	<200509261710.j8QHAkE7008871@turing-police.cc.vt.edu>
	<87vf0npip4.fsf@coraid.com>
	<20050926.162131.118639723.davem@davemloft.net>
From: Ed L Cashin <ecashin@coraid.com>
Date: Tue, 27 Sep 2005 17:41:45 -0400
In-Reply-To: <20050926.162131.118639723.davem@davemloft.net> (David S.
 Miller's message of "Mon, 26 Sep 2005 16:21:31 -0700 (PDT)")
Message-ID: <87wtl22nom.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> From: Ed L Cashin <ecashin@coraid.com>
> Date: Mon, 26 Sep 2005 18:28:39 -0400
>
>> No, it looks like alloc_skb just kmallocs the data, so I'd need to
>> follow up with something like this:
>
> You should explicitly initialize the data areas of the SKB as you
> "push" and "put" to allocate space in the data buffer, not right
> after alloc_skb() and before you've allocate any space.

Sure, we can do that.  I will resend these patches.

-- 
  Ed L Cashin <ecashin@coraid.com>


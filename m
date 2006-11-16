Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424608AbWKPXrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424608AbWKPXrc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424601AbWKPXrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:47:32 -0500
Received: from localhost.localdomain ([127.0.0.1]:1208 "EHLO localhost")
	by vger.kernel.org with ESMTP id S1424600AbWKPXrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:47:31 -0500
Date: Thu, 16 Nov 2006 18:47:30 -0500 (EST)
Message-Id: <20061116.184730.35014107.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IPv4: ip_options_compile() how can we avoid blowing up on a
 NULL skb???
From: David Miller <davem@davemloft.net>
In-Reply-To: <9a8748490611161434oc393db0o1e1c23ba99b1c796@mail.gmail.com>
References: <9a8748490611161434oc393db0o1e1c23ba99b1c796@mail.gmail.com>
X-Mailer: Mew version 5.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jesper Juhl" <jesper.juhl@gmail.com>
Date: Thu, 16 Nov 2006 23:34:14 +0100

> So if 'skb' is NULL, the only route I see that doesn't cause a NULL
> pointer deref is if  (opt != NULL)  and at the same time
> (opt->is_data != NULL)  .   Is that guaranteed in any way?

Yes, it is guarenteed, all callers  make sure these invariants
hold true.

I'm very happy to accept a patch which assert's this using BUG()
checks :-)

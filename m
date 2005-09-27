Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVI0Euf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVI0Euf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 00:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVI0Euf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 00:50:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26801
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964804AbVI0Eue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 00:50:34 -0400
Date: Mon, 26 Sep 2005 21:50:29 -0700 (PDT)
Message-Id: <20050926.215029.97127602.davem@davemloft.net>
To: coywolf@gmail.com
Cc: alex.williamson@hp.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] sys_sendmsg() alignment bug fix
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <2cd57c90050926204022fb22ca@mail.gmail.com>
References: <1127764921.6529.60.camel@tdi>
	<2cd57c90050926204022fb22ca@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coywolf Qi Hunt <coywolf@gmail.com>
Date: Tue, 27 Sep 2005 11:40:38 +0800

> On 9/27/05, Alex Williamson <alex.williamson@hp.com> wrote:
> >    The patch below adds an alignment attribute to the buffer used in
> > sys_sendmsg().  This eliminates an unaligned access warning on ia64.
> 
> Is this a warning fix or bug fix?

It doesn't generate a warning, but it does generate totally
unnecessary unaligned access traps on RISC systems.

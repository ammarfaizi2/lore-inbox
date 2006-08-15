Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965321AbWHOJPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965321AbWHOJPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965323AbWHOJPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:15:03 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33940
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965321AbWHOJPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:15:01 -0400
Date: Tue, 15 Aug 2006 02:15:03 -0700 (PDT)
Message-Id: <20060815.021503.71555009.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: [PATCH] ISDN: fix double free bug in isdn_net
From: David Miller <davem@davemloft.net>
In-Reply-To: <9a8748490608150208v4e8b7dccl6dd501a6f2cda4fc@mail.gmail.com>
References: <200608122248.22639.jesper.juhl@gmail.com>
	<20060815.020004.76775981.davem@davemloft.net>
	<9a8748490608150208v4e8b7dccl6dd501a6f2cda4fc@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jesper Juhl" <jesper.juhl@gmail.com>
Date: Tue, 15 Aug 2006 11:08:35 +0200

> Hmm, perhaps I made a mistake and missed a path. Maybe it would be
> better to fix if by making isdn_writebuf_skb_stub() always set the skb
> to NULL when it does free it. That would add a few more assignments
> but should ensure the right result always.
> What do you say?

Do we know if the ->writebuf_skb() method ever frees the skb?  If it
never does, then yes your suggestion would be one way to handle this.

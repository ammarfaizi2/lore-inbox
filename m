Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWGEVaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWGEVaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWGEVaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:30:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21401 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964853AbWGEVaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:30:07 -0400
Message-ID: <44AC2F51.7070804@garzik.org>
Date: Wed, 05 Jul 2006 17:29:53 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: marcelo@kvack.org, davem@davemloft.net, matthew@wil.cx,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH-2.4] 2 oopses in ethtool
References: <20060705204706.GA254@1wt.eu>
In-Reply-To: <20060705204706.GA254@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi Marcelo,
> 
> I got an oops today with 2.4.33-rc2 when playing ethtool games on my TG3
> NIC. It was caused by a typo in ethtool.c, and while fixing it, I discovered
> a second one.
> 
> David, a quick check showed that 2.6.17.1 has the first one fixed but not
> second one (ethtool_set_pauseparam), so you might want to merge it too.
> 
> Cheers,
> Willy
> 
> From: Willy Tarreau <willy@wtap.(none)>
> Date: Wed, 5 Jul 2006 22:34:52 +0200
> Subject: [PATCH] ethtool: two oopses in ethtool_set_coalesce() and ethtool_set_pauseparam()
> 
> The function pointers which were checked were for their get_* counterparts.
> Typically a copy-paste typo.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>

ACK


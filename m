Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbTEaGf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 02:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbTEaGf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 02:35:59 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:24001 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264164AbTEaGf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 02:35:58 -0400
Date: Sat, 31 May 2003 08:48:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "David S. Miller" <davem@redhat.com>
Cc: jmorris@intercode.com.au, dwmw2@infradead.org,
       matsunaga_kazuhisa@yahoo.co.jp, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Message-ID: <20030531064851.GA20822@wohnheim.fh-wedel.de>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de> <Mutt.LNX.4.44.0305310101550.30969-100000@excalibur.intercode.com.au> <20030530174319.GA16687@wohnheim.fh-wedel.de> <20030530.171410.104043496.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030530.171410.104043496.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 17:14:10 -0700, David S. Miller wrote:
> 
> Actually, your idea is interesting.  Are you going to use
> per-cpu workspaces?

Yes, I already am.

> I think the best scheme is 2 per-cpu workspaces, one for
> normal and one for softirq context.

Agreed.  Current patch doesn't cover softirq context yet.

> No locking needed whatsoever.  I hope it can work :-)

How about preemption?  zlib operations take their time, so at least on
up, it makes sense to preempt them, when not in softirq context.  Can
this still be done lockless?

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 

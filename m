Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTEaACa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 20:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTEaACa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 20:02:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19379 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264075AbTEaAC3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 20:02:29 -0400
Date: Fri, 30 May 2003 17:14:10 -0700 (PDT)
Message-Id: <20030530.171410.104043496.davem@redhat.com>
To: joern@wohnheim.fh-wedel.de
Cc: jmorris@intercode.com.au, dwmw2@infradead.org,
       matsunaga_kazuhisa@yahoo.co.jp, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030530174319.GA16687@wohnheim.fh-wedel.de>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de>
	<Mutt.LNX.4.44.0305310101550.30969-100000@excalibur.intercode.com.au>
	<20030530174319.GA16687@wohnheim.fh-wedel.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jörn Engel <joern@wohnheim.fh-wedel.de>
   Date: Fri, 30 May 2003 19:43:19 +0200
   
   What contention were you talking about? :)

Actually, your idea is interesting.  Are you going to use
per-cpu workspaces?

I think the best scheme is 2 per-cpu workspaces, one for
normal and one for softirq context.

No locking needed whatsoever.  I hope it can work :-)

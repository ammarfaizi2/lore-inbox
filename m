Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbTEaGnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 02:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTEaGnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 02:43:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28085 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264174AbTEaGnX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 02:43:23 -0400
Date: Fri, 30 May 2003 23:55:05 -0700 (PDT)
Message-Id: <20030530.235505.23020750.davem@redhat.com>
To: joern@wohnheim.fh-wedel.de
Cc: jmorris@intercode.com.au, dwmw2@infradead.org,
       matsunaga_kazuhisa@yahoo.co.jp, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030531064851.GA20822@wohnheim.fh-wedel.de>
References: <20030530174319.GA16687@wohnheim.fh-wedel.de>
	<20030530.171410.104043496.davem@redhat.com>
	<20030531064851.GA20822@wohnheim.fh-wedel.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jörn Engel <joern@wohnheim.fh-wedel.de>
   Date: Sat, 31 May 2003 08:48:51 +0200

   > No locking needed whatsoever.  I hope it can work :-)
   
   How about preemption?  zlib operations take their time, so at least on
   up, it makes sense to preempt them, when not in softirq context.  Can
   this still be done lockless?

You'll need to disable preemption.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTFIWtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 18:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTFIWtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 18:49:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51864 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262254AbTFIWtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 18:49:49 -0400
Date: Mon, 09 Jun 2003 16:00:13 -0700 (PDT)
Message-Id: <20030609.160013.74730356.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: wa@almesberger.net, chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0306100011230.5042-100000@serv>
References: <Pine.LNX.4.44.0306082228460.5042-100000@serv>
	<20030608.223501.71104915.davem@redhat.com>
	<Pine.LNX.4.44.0306100011230.5042-100000@serv>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Tue, 10 Jun 2003 00:59:21 +0200 (CEST)
   
   You still need to synchronize with already running functions

netdev->dead = 1;
netdev->op_this = NULL;
netdev->op_that = NULL;
netdev->op_whatever = NULL;
synchronize_kernel();

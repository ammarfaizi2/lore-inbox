Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUAZVO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUAZVO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:14:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59339 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265258AbUAZVO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:14:56 -0500
Date: Mon, 26 Jan 2004 13:02:42 -0800 (PST)
Message-Id: <20040126.130242.74547942.davem@redhat.com>
To: bunk@fs.tum.de
Cc: jt@hpl.hp.com, marcelo.tosatti@cyclades.com,
       irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] fix via-ircc.c .text.exit error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040126210126.GG513@fs.tum.de>
References: <20040125004030.GE6441@fs.tum.de>
	<20040126192836.GA17134@bougret.hpl.hp.com>
	<20040126210126.GG513@fs.tum.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Adrian Bunk <bunk@fs.tum.de>
   Date: Mon, 26 Jan 2004 22:01:26 +0100

   On Mon, Jan 26, 2004 at 11:28:36AM -0800, Jean Tourrilhes wrote:
   > 	Thanks you Adrian. Yes, I must confess that I never test
   > non-modular build (because it doesn't work).
   
   Are you saying it might compile statically, but it won't work?
   
It won't link because many IRDA drivers erroneously don't
mark their module_{init,exit}() routines static, thus
symbols conflict.

I'm fixing that now.

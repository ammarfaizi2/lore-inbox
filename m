Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVAJAFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVAJAFX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVAJAFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:05:23 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:201 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262003AbVAJAFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:05:19 -0500
Subject: Re: [PATCH] kernel/printk.c  lockless access
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@osdl.org>, Linas Vepstas <linas@austin.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20050109104425.GA9524@janus>
References: <20050106195812.GL22274@austin.ibm.com>
	 <20050106161241.11a8d07c.akpm@osdl.org>
	 <20050107002648.GD14239@krispykreme.ozlabs.ibm.com>
	 <41DDD6FA.2050403@osdl.org>
	 <1105062162.24896.311.camel@localhost.localdomain>
	 <20050109104425.GA9524@janus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105278075.12028.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 09 Jan 2005 23:00:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-09 at 10:44, Frank van Maarseveen wrote:
> What about UDP (or just eth) broadcasting the oops and catching it
> on another system? That would be useful if one has a lot of systems
> (I have about 40) and makes it possible to immediately alert someone
> without the need for ping games.

netdump and kgdb both can do this. The 2.6.10-tiny1 has some nice kgdb
patches that include using the polling network debug interfaces.


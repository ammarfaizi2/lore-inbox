Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267016AbSKVJFa>; Fri, 22 Nov 2002 04:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbSKVJFa>; Fri, 22 Nov 2002 04:05:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:48543 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267016AbSKVJFa>;
	Fri, 22 Nov 2002 04:05:30 -0500
Date: Fri, 22 Nov 2002 01:09:34 -0800 (PST)
Message-Id: <20021122.010934.126934922.davem@redhat.com>
To: error27@email.com
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
       torvalds@transmeta.com
Subject: Re: calling schedule() from interupt context
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021122085441.2127.qmail@email.com>
References: <20021122085441.2127.qmail@email.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "dan carpenter" <error27@email.com>
   Date: Fri, 22 Nov 2002 03:54:41 -0500

   module_put ==> put_cpu ==> preempt_schedule ==> schedule

Oh we can't kill module references from interrupts?

Egads... that makes lots of the networking stuff
nearly impossible as SKB's hold references to modules
and thus skb freeing can thus put modules.

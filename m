Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbTAPAIL>; Wed, 15 Jan 2003 19:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTAPAIL>; Wed, 15 Jan 2003 19:08:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54447 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266932AbTAPAIK>;
	Wed, 15 Jan 2003 19:08:10 -0500
Date: Wed, 15 Jan 2003 16:07:16 -0800 (PST)
Message-Id: <20030115.160716.23576593.davem@redhat.com>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix up RTM_SETLINK handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52smvukic3.fsf@topspin.com>
References: <52smvukic3.fsf@topspin.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 14 Jan 2003 23:01:00 -0800

   To call the netdev notifier chain I had to make netdev_chain not be
   static.  I added the declaration to <linux/netdevice.h> but I am open
   to other ways to give rtnetlink.c access to netdev_chain.
   
Ummm, what is the problem with using register_netdevice_notifier()?
It is precisely there so that netdev_chain need not be exported.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbSLIULz>; Mon, 9 Dec 2002 15:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbSLIULz>; Mon, 9 Dec 2002 15:11:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25744 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266043AbSLIULy>;
	Mon, 9 Dec 2002 15:11:54 -0500
Date: Mon, 09 Dec 2002 12:15:57 -0800 (PST)
Message-Id: <20021209.121557.17268348.davem@redhat.com>
To: manfred@colorfullife.com
Cc: wli@holomorphy.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-BK + 24 CPUs
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DF4CCCE.7040407@colorfullife.com>
References: <20021208212808.GY9882@holomorphy.com>
	<1039389778.13079.1.camel@rth.ninka.net>
	<3DF4CCCE.7040407@colorfullife.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Manfred Spraul <manfred@colorfullife.com>
   Date: Mon, 09 Dec 2002 18:03:10 +0100

   Unfortunately zero-copy doesn't help to avoid the schedules:
   Zero copy just avoid the copy to kernel - you still need one schedule 
   for each page to be transfered.

The zerocopy patches copied up to 64k (or rather, 16 pages, something
like that) at once, that's going to lead to 16 times less schedules.

The 64k number was decided arbitrarily (it's what freebsd's pipe code
uses) and it can be experimented with.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTE3Ari (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 20:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTE3Ari
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 20:47:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63402 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263195AbTE3Ari (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 20:47:38 -0400
Date: Thu, 29 May 2003 17:58:57 -0700 (PDT)
Message-Id: <20030529.175857.45881809.davem@redhat.com>
To: akpm@digeo.com
Cc: bonganilinux@mweb.co.za, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: 2.5.70-mm1 Strangeness
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030529175135.7b204aaf.akpm@digeo.com>
References: <20030529135541.7c926896.akpm@digeo.com>
	<20030529.171114.34756018.davem@redhat.com>
	<20030529175135.7b204aaf.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Thu, 29 May 2003 17:51:35 -0700

   Yes, 19470 entries.  But note that each entry is 4096 bytes.
   
   Something seems to have gone and bumped the object size from 240
   bytes up to 4096.

I see.

Meanwhile, you can control how large the routing cache allows itself
to grow by changing /proc/sys/net/ipv4/route/max_size.  It is the
maximum number of entries the routing cache will allow itself to
expand to.

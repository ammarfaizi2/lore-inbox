Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266865AbUAXFi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 00:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUAXFi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 00:38:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35510 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266865AbUAXFi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 00:38:56 -0500
Date: Fri, 23 Jan 2004 21:30:13 -0800 (PST)
Message-Id: <20040123.213013.41659820.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Simplify net/flow.c 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040124050843.320902C056@lists.samba.org>
References: <20040122195104.31cc2496.akpm@osdl.org>
	<20040124050843.320902C056@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Fri, 23 Jan 2004 17:55:28 +1100

   In message <20040122195104.31cc2496.akpm@osdl.org> you write:
   > -	down(&cpucontrol);
   > +	down_cpucontrol();
   
   OK.  Although I think I prefer to have down_cpucontrol() defined under
   #ifdef CONFIG_HOTPLUG_CPU, and revert to using a normal sem here as
   well to cover the CONFIG_HOTPLUG_CPU=n CONFIG_SMP=y case.  But I will
   produce an additional patch with the hotplug cpu patches.

Rusty take a look at Linus's current BK tree, it should be
to your satisfaction I think :)

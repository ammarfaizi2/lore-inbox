Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTEGE6d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTEGE6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:58:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16621 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262853AbTEGE6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:58:32 -0400
Date: Tue, 06 May 2003 21:03:32 -0700 (PDT)
Message-Id: <20030506.210332.23029446.davem@redhat.com>
To: akpm@digeo.com
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: tg3 - irq #: nobody cared!
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030506220802.6d494326.akpm@digeo.com>
References: <1052258580.4495.12.camel@w-jstultz2.beaverton.ibm.com>
	<1052283509.9817.1.camel@rth.ninka.net>
	<20030506220802.6d494326.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Tue, 6 May 2003 22:08:02 -0700
   
   So I'd be suspecting the scenario which Alan outlined: the IRQ
   handler looped around, scooped up the interrupt source before the
   APIC delivered the IRQ.

That certainly what happens with tg3.
   
   Suggest we ignore these reports until that is sorted out.

Ok.

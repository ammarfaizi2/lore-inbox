Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTDPOzq (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264447AbTDPOzq 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:55:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59269 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264446AbTDPOzp 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:55:45 -0400
Date: Wed, 16 Apr 2003 08:00:44 -0700 (PDT)
Message-Id: <20030416.080044.25878686.davem@redhat.com>
To: ak@muc.de
Cc: willy@debian.org, akpm@digeo.com, linux-kernel@vger.kernel.org,
       anton@samba.org, schwidefsky@de.ibm.com, davidm@hpl.hp.com,
       matthew@wil.cx, ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030416150427.GA2496@averell>
References: <20030416144312.GA2327@averell>
	<20030416145532.GA1505@parcelfarce.linux.theplanet.co.uk>
	<20030416150427.GA2496@averell>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: Wed, 16 Apr 2003 17:04:27 +0200

   Sure, but you use a 64bit read/store in set_bit/clear_bit etc., right? 
   
   If yes then you can't use this unless you rewrite them to use 32bit store
   - otherwise it will conflict with the atomic_t counter in the 64bit slot
   which is not protected.
   
It will be protected by the same spinlock, look at how the
thing works :-)

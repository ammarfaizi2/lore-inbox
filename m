Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbTDPOxp (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTDPOxp 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:53:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54661 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264442AbTDPOxj 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:53:39 -0400
Date: Wed, 16 Apr 2003 07:58:37 -0700 (PDT)
Message-Id: <20030416.075837.03516293.davem@redhat.com>
To: ak@muc.de
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030416145853.GA2421@averell>
References: <20030416144312.GA2327@averell>
	<20030416.073814.124147956.davem@redhat.com>
	<20030416145853.GA2421@averell>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: Wed, 16 Apr 2003 16:58:53 +0200
   
   In this case part of the unsigned long could be accessed directly 
   using the aliasing.

They use the same ATOMIC_HASH() for both atomic_t's and bitops.
I don't see how an alias can be generated.  This thing must
work for any ordering of unsigned long *'s and atomic_t's.


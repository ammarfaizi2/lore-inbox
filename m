Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbTDPOVu (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTDPOVu 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:21:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32901 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264385AbTDPOVu 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:21:50 -0400
Date: Wed, 16 Apr 2003 07:26:38 -0700 (PDT)
Message-Id: <20030416.072638.65480350.davem@redhat.com>
To: ak@muc.de
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030416140715.GA2159@averell>
References: <20030415112430.GA21072@averell>
	<20030416.054521.26525548.davem@redhat.com>
	<20030416140715.GA2159@averell>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: Wed, 16 Apr 2003 16:07:15 +0200

   How so? Of course I could write an generic set_bit32, but the question
   is if these bit operations would be still atomic on SMP and not conflict with
   fields occuping the same 8 byte slot. I remember you flaming someone 
   some time ago because he used set_bit in an atomic fashion on a type smaller
   than unsigned long for example.

It's OK if you align the pointer to 8 bytes, and subsequently the bit
offset as appropriate. :-)


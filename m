Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbTDPMkX (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 08:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264336AbTDPMkX 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 08:40:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61572 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264335AbTDPMkW 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 08:40:22 -0400
Date: Wed, 16 Apr 2003 05:45:21 -0700 (PDT)
Message-Id: <20030416.054521.26525548.davem@redhat.com>
To: ak@muc.de
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030415112430.GA21072@averell>
References: <20030415112430.GA21072@averell>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: Tue, 15 Apr 2003 13:24:30 +0200
   
   I worked around this by declaring a new data type atomic_bitmask32
   with matching set_bit32/clear_bit32 etc. interfaces. Currently only 
   on x86-64 aomitc_bitmask32 is defined to unsigned, everybody else
   still uses unsigned long. The other 64bit architectures can define it to
   unsigned too if they can confirm that it's ok to do.

I have no problem with this.

If you are clever, you can define a generic version even for the
"unsigned long" 64-bit platforms.  It's left as an exercise to
the reader :-)

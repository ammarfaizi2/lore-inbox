Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSHXAHG>; Fri, 23 Aug 2002 20:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSHXAHF>; Fri, 23 Aug 2002 20:07:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4511 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314446AbSHXAHF>;
	Fri, 23 Aug 2002 20:07:05 -0400
Date: Fri, 23 Aug 2002 16:55:46 -0700 (PDT)
Message-Id: <20020823.165546.40701755.davem@redhat.com>
To: manand@us.ibm.com
Cc: alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, bhartner@us.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OFF2DE6049.2BE570E3-ON87256C1E.0080C56A@boulder.ibm.com>
References: <OFF2DE6049.2BE570E3-ON87256C1E.0080C56A@boulder.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Mala Anand" <manand@us.ibm.com>
   Date: Fri, 23 Aug 2002 18:38:59 -0500

   To name a few, interrupts are disabled when skbs are put back to the
   hot_list

A few cycles, at best, it should not be enough to skew the profiling

   and when the cache list is accessed in the slab allocator. Am I missing
   something? Please help me to understand.

Which means if this were enough to skew profiling, it would make the
program counter of the interrupt enable instruction in the SLAB code
show up clearly in the profiles.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261923AbSIZApE>; Wed, 25 Sep 2002 20:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261925AbSIZApE>; Wed, 25 Sep 2002 20:45:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27009 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261923AbSIZApD>;
	Wed, 25 Sep 2002 20:45:03 -0400
Date: Wed, 25 Sep 2002 17:44:05 -0700 (PDT)
Message-Id: <20020925.174405.102576685.davem@redhat.com>
To: ak@suse.de
Cc: niv@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020926024645.A15246@wotan.suse.de>
References: <p73n0q5sib2.fsf@oldwotan.suse.de>
	<20020925.172931.115908839.davem@redhat.com>
	<20020926024645.A15246@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Thu, 26 Sep 2002 02:46:45 +0200

   > Also not necessary, only the top level cache really needs to be
   > top performance.
   
   Sure, but if they were unified (that is what I understood what the original
   poster wanted to do) then they would be suddenly much more performance
   critical and need fine grained locking.
   
This can be made, if necessary.  If the toplevel flow cache lookup
table is sized appropriately, I doubt anything will be needed.
   
   P.S.: One big performance problem currently is ip_conntrack. It has a bad
   hash function and tends to have a too big working set (beyond cache size)
   Some tuning in this regard would help a lot of workloads.
   
This is well understood problem and a fix is in the works.
See the netfilter lists.

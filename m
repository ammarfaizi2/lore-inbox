Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319326AbSIFSqW>; Fri, 6 Sep 2002 14:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319329AbSIFSqW>; Fri, 6 Sep 2002 14:46:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9095 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319326AbSIFSqU>;
	Fri, 6 Sep 2002 14:46:20 -0400
Date: Fri, 06 Sep 2002 11:43:36 -0700 (PDT)
Message-Id: <20020906.114336.132077566.davem@redhat.com>
To: Martin.Bligh@us.ibm.com
Cc: haveblue@us.ibm.com, ak@suse.de, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <61557945.1031312716@[10.10.2.3]>
References: <20020906.113652.40767574.davem@redhat.com>
	<61557945.1031312716@[10.10.2.3]>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
   Date: Fri, 06 Sep 2002 11:45:17 -0700

   >    Actually, oprofile separated out the acenic module from the rest of the 
   >    kernel.  I should have included that breakout as well. but it was only 1.3 
   >    of CPU:
   >    1.3801 0.0000 /lib/modules/2.4.18+O1/kernel/drivers/net/acenic.o
   > 
   > We thought you were using e1000 in these tests?
   
   e1000 on the server, those profiles were client side.
   
Ok.  BTW acenic is packet rate limited by the speed of the
MIPS cpus on the card.

It might be instramental to disable HW checksumming in the
acenic driver and see what this does to your results.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSJQKTa>; Thu, 17 Oct 2002 06:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbSJQKTa>; Thu, 17 Oct 2002 06:19:30 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:5799 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261349AbSJQKT3>;
	Thu, 17 Oct 2002 06:19:29 -0400
Date: Thu, 17 Oct 2002 15:59:55 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: netdev <netdev@oss.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Qdisc drops not being reported to user space
Message-ID: <20021017155955.E20237@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime back, I had posted a patch to report Qdisc drops under /proc/net/dev.
I'd noticed that Qdisc.drops was not being reported for the default queuing
discipline (pfifo_fast).  I was told that my approach mucked SNMP data.
I was also told that prio will be made the default queuing discipline and
pfifo_fast will be done away with. Is this the case even now? will prio
be made the default queuing disc in the 2.5 time frame? If not, any
solution in sight to report Qdisc drops to userland? (I think there is
a kernel patch and a patch for tc from Jamal). I have noticed Qdisc
drops under webserver loads, and heavy tx loads (I used my  proc reporting
patch .. it did not break ifconfig atleast..).  IMO It'd not be right if
packets are being dropped by the kernel (default queuing discipline) and the
unsuspecting admin has no means to find that out.  IMHO It'd also not be fair 
to expect users to use CONFIG_NET_SCH_PRIO and add the prio qdisc before 
using a n/w interface just to be able to make out Qdisc drops.
 
One more thing...IMHO, there must be some documentation somewhere ....
tc man page (which doesn't exist as of now?) or atleast the readme
which should indicate to the user that drops seen from ifconfig
(packets dropped by the adapter) are different from packets dropped from
the qdisc as shown by tc. 
 
Thanks,
Kiran

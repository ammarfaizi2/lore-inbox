Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319156AbSILXPv>; Thu, 12 Sep 2002 19:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319164AbSILXPv>; Thu, 12 Sep 2002 19:15:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2498 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319156AbSILXPu>;
	Thu, 12 Sep 2002 19:15:50 -0400
Date: Thu, 12 Sep 2002 16:12:25 -0700 (PDT)
Message-Id: <20020912.161225.20790415.davem@redhat.com>
To: hadi@cyberus.ca
Cc: todd@osogrande.com, tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.30.0209120811300.16149-100000@shell.cyberus.ca>
References: <Pine.LNX.4.44.0209120119580.25406-100000@gp>
	<Pine.GSO.4.30.0209120811300.16149-100000@shell.cyberus.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jamal <hadi@cyberus.ca>
   Date: Thu, 12 Sep 2002 08:30:44 -0400 (EDT)
   
   In regards to the receive side CPU utilization improvements: I think
   that NAPI does a good job at least in getting ridding of the biggest
   offender -- interupt overload.

I disagree, at least for bulk receivers.  We have no way currently to
get rid of the data copy.  We desperately need sys_receivefile() and
appropriate ops all the way into the networking, then the necessary
driver level support to handle the cards that can do this.

Once 10gbit cards start hitting the shelves this will convert from a
nice perf improvement into a must have.


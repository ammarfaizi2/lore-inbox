Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272340AbSISTRX>; Thu, 19 Sep 2002 15:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272359AbSISTRW>; Thu, 19 Sep 2002 15:17:22 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:10382 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S272340AbSISTRW>; Thu, 19 Sep 2002 15:17:22 -0400
Message-ID: <3D8A23EB.D22D971E@nortelnetworks.com>
Date: Thu, 19 Sep 2002 15:22:19 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-6mdkenterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kswapd running for 300+ms in 2.4.18?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a box on which we are trying to get some reasonable latencies (ie 10s of ms is fine, 100s is
not).  

We have an application that wants to be scheduled every 50ms or so, and a custom scheduler that
should allow for this.  If it sleeps for more than 300ms it logs the fact and dumps a history of the
last 128 processes scheduled along with timing info.  Based on this, we are seeing kswapd
occasionally running for ~340ms at a time.

Is there an easy fix to reduce this latency, or would it be a nasty intrusive change?

Thanks,

Chris

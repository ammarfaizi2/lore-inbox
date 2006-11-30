Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030737AbWK3REI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030737AbWK3REI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbWK3REH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:04:07 -0500
Received: from mailgw1.fnal.gov ([131.225.111.11]:29589 "EHLO mailgw1.fnal.gov")
	by vger.kernel.org with ESMTP id S1030731AbWK3REF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:04:05 -0500
Date: Thu, 30 Nov 2006 11:04:00 -0600
From: Wenji Wu <wenji@fnal.gov>
Subject: RE: [patch 1/4] - Potential performance bottleneck for Linxu TCP
In-reply-to: <20061130103240.GA25733@elte.hu>
To: Ingo Molnar <mingo@elte.hu>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Miller <davem@davemloft.net>,
       akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-to: wenji@fnal.gov
Message-id: <HNEBLGGMEGLPMPPDOPMGAEANCGAA.wenji@fnal.gov>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The solution is really simple and needs no kernel change at all: if you
>want the TCP receiver to get a larger share of timeslices then either
>renice it to -20 or renice the other tasks to +19.

Simply give a larger share of timeslices to the TCP receiver won't solve the
problem.  No matter what the timeslice is, if the TCP receiving process has
packets within backlog, and the process is expired and moved to the expired
array, RTO might happen in the TCP sender.

The solution does not look like that simple.

wenji





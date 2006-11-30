Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936444AbWK3U6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936444AbWK3U6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936437AbWK3U6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:58:10 -0500
Received: from mailgw2.fnal.gov ([131.225.111.12]:32896 "EHLO mailgw2.fnal.gov")
	by vger.kernel.org with ESMTP id S935687AbWK3U6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:58:06 -0500
Date: Thu, 30 Nov 2006 14:58:00 -0600
From: Wenji Wu <wenji@fnal.gov>
Subject: RE: [patch 1/4] - Potential performance bottleneck for Linxu TCP
In-reply-to: <20061130202034.GB14696@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       David Miller <davem@davemloft.net>, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-to: wenji@fnal.gov
Message-id: <HNEBLGGMEGLPMPPDOPMGAEAOCGAA.wenji@fnal.gov>
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


>if you still have the test-setup, could you nevertheless try setting the
>priority of the receiving TCP task to nice -20 and see what kind of
>performance you get?

A process with nice of -20 can easily get the interactivity status. When it
expires, it still go back to the active array. It just hide the TCP problem,
instead of solving it.

For a process with nice value of -20, it will have the following advantages
over other processes:
(1) its timeslice is 800ms, the timeslice of a process with a nice value of
0 is 100ms
(2) it has higher priority than other processes
(3) it is easier to gain the interactivity status.

The chances that the process expires and moves to the expired array with
packets within backlog is much reduces, but still has the chance.


wenji



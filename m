Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263716AbUC3PR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUC3PR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:17:57 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:52747 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263718AbUC3PQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:16:47 -0500
Message-ID: <406993D1.8040705@techsource.com>
Date: Tue, 30 Mar 2004 10:35:45 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Storage Architect Part 1: Re: [PATCH] speed up SATA (resend 3)
References: <Pine.LNX.4.10.10403300000270.11654-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10403300000270.11654-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow I missed this discussion on the list, but I caught it on kerneltrap.

Anyhow, what I don't understand is why it would be so hard to have the 
block layer measure latency and dynamically adjust for each device. 
Start somewhat small, and when the block layer sees that a given device 
can handle larger requests without blowing latency requirements, 
increase the request size.  Keep a running average.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVJQU0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVJQU0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVJQU0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:26:00 -0400
Received: from zrtps0kp.nortelnetworks.com ([47.140.192.56]:48566 "EHLO
	zrtps0kp.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751336AbVJQUZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:25:59 -0400
Message-ID: <435408AD.4060505@nortel.com>
Date: Mon, 17 Oct 2005 14:25:17 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com,
       Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com> <4353E6F1.8030206@cosmosbay.com> <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org> <4353F7B5.1040101@cosmosbay.com> <Pine.LNX.4.64.0510171218490.3369@g5.osdl.org> <4353FDE8.8070909@cosmosbay.com> <Pine.LNX.4.64.0510171304580.3369@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510171304580.3369@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2005 20:25:25.0428 (UTC) FILETIME=[E8163740:01C5D358]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Yes, it may screw up some latency stuff, but quite frankly, even with your 
> patch and even ignoring the call_rcu_bh case, I'm convinced you can easily 
> get into the situation where softirqd just doesn't run soon enough.
> 
> But at least I think I understand _why_ rcu processing was delayed.

Could this be related to the "rename14 LTP test with /tmp as tmpfs and 
HIGHMEM causes OOM-killer invocation due to zone normal exhaustion" issue?

Chris

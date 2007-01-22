Return-Path: <linux-kernel-owner+w=401wt.eu-S1751763AbXAVPwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbXAVPwq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbXAVPwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:52:45 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:38959 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751763AbXAVPwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:52:45 -0500
Message-ID: <45B4DDBF.8040706@cfl.rr.com>
Date: Mon, 22 Jan 2007 10:52:31 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <45A5D4A7.7020202@yahoo.com.au> <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org> <200701201719.15341.vda.linux@googlemail.com>
In-Reply-To: <200701201719.15341.vda.linux@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2007 15:53:07.0898 (UTC) FILETIME=[690179A0:01C73E3D]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14950.003
X-TM-AS-Result: No--3.739600-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> What will happen if we just make open ignore O_DIRECT? ;)
> 
> And then anyone who feels sad about is advised to do it
> like described here:
> 
> http://lkml.org/lkml/2002/5/11/58

Then database and other high performance IO users will be broken.  Most 
of Linus's rant there is being rehashed now in this thread, and it has 
been pointed out that using mmap instead is unacceptable because it is 
inherently _synchronous_ and the app can not tolerate the page faults on 
read, and handling IO errors during the page fault is impossible/highly 
problematic.



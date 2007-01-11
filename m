Return-Path: <linux-kernel-owner+w=401wt.eu-S964893AbXAKXGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbXAKXGo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbXAKXGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:06:44 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:10010 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964893AbXAKXGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:06:43 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=kERaHBJdoMD+hcq27Nfb6XsuARh2oNzV0TwbCMwHKlq58t7hq51e7c4FRo02CWVAP4ggLwB2uO0aOraH6oyBeL8W0SXZ/CK2bdqffGGi3sU+Q3/kUSSZsfl3ccbXbYD8kGBCcR8Wk21EKGkF6EZxC9IdTlo4YCW27VwnMMB6mFU=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Phillip Susi'" <psusi@cfl.rr.com>, "'Michael Tokarev'" <mjt@tls.msk.ru>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>, "'Viktor'" <vvp01@inbox.ru>,
       "'Aubrey'" <aubreylee@gmail.com>, "'Hugh Dickins'" <hugh@veritas.com>,
       <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
       <kenneth.w.chen@intel.com>, <akpm@osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <45A6704A.40205@tls.msk.ru> <45A6C1D2.9020104@cfl.rr.com>
Subject: RE: O_DIRECT question
Date: Thu, 11 Jan 2007 15:06:50 -0800
Message-ID: <000001c735d5$2fea7830$262d100a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <45A6C1D2.9020104@cfl.rr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: Acc11HN50hOOeOrzQ5mrR9+8MQU7vQAAIp+w
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The other problem besides the inability to handle IO errors is that
> mmap()+msync() is synchronous.  You need to go async to keep 
> the pipelines full.

msync(addr, len, MS_ASYNC); doesn't do what you want?

> Now if someone wants to implement an aio version of msync and 
> mlock, that might do the trick.  At least for MMU systems.  
> Non MMU systems just can't play mmap type games.
> 


Return-Path: <linux-kernel-owner+w=401wt.eu-S1754894AbXABSWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbXABSWG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbXABSWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:22:06 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:36473 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754886AbXABSWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:22:05 -0500
In-Reply-To: <20070102110136.GA20640@infradead.org>
References: <000001c717c0$f82b5ea0$2589030a@amr.corp.intel.com> <28F99581-3A2A-45BD-8F00-B554313E2C26@oracle.com> <20070102110136.GA20640@infradead.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <712B05B5-F7E2-4F19-9980-2CA95C5D15AC@oracle.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] remove redundant iov segment check
Date: Tue, 2 Jan 2007 10:22:00 -0800
To: Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I wonder if it wouldn't be better to make this change as part of a
>> larger change that moves towards an explicit iovec container struct
>> rather than bare 'struct iov *' and 'nr_segs' arguments.

> I suspect it should be rather trivial to get this started.  As a first
> step we simply add a
>
> struct iodesc {
> 	int nr_segs;
> 	struct iovec ioc[]
> };

Agreed, does anyone plan to try this in the near future?  I can  
always throw it at the bottom of the todo list :/.

- z

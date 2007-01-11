Return-Path: <linux-kernel-owner+w=401wt.eu-S1750889AbXAKSgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbXAKSgK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXAKSgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:36:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:41911 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbXAKSgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:36:09 -0500
In-Reply-To: <13426df10701110955y18381bbeg5f23c0e375383836@mail.gmail.com>
References: <13426df10701110939k21f7bb1dy38d2b34ca37a5a36@mail.gmail.com> <45A67987.6030508@firmworks.com> <13426df10701110955y18381bbeg5f23c0e375383836@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d2b1934bee9f965f755a8d0851d25d81@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: "Mitch Bradley" <wmb@firmworks.com>,
       "OLPC Developer's List" <devel@laptop.org>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Thu, 11 Jan 2007 19:36:22 +0100
To: "ron minnich" <rminnich@gmail.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Segher has a modification to the devtree patch that creates a lower
>> level ops vector that can be implemented with callback or 
>> non-callback.
>>
>> It is still being tested.

It currently only hooks up OLPC, and I don't have any of
those [hint hint], so I need external testers.  I'll send
the patch to LKML if it does work.  However, the way it
implements the filesystem will need significant changes,
but we'll discuss that later :-)

> Wonderful! If the non-callback version works out,

We use it on many PowerPC platforms already, it works
just fine.

> then we can greatly
> widen the potential use of the OF device tree for many BIOSes. If that
> works, then we can put the proprietary tables into a small box and
> ignore them :-)

Yup, the DTC-generated tree is just a single binary blob
from the perspective of passing it around.


Segher


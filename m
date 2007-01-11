Return-Path: <linux-kernel-owner+w=401wt.eu-S1751301AbXAKSBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbXAKSBD (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbXAKSBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:01:03 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50845 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbXAKSBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:01:01 -0500
Date: Thu, 11 Jan 2007 10:00:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <20070111174214.676d15b9@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0701110958370.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru>
 <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <20070111174214.676d15b9@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2007, Alan wrote:
> 
> Well you can - its called SG_IO and that really does get the OS out of
> the way. O_DIRECT gets crazy when you stop using it on devices directly
> and use it on files

Well, on a raw disk, O_DIRECT is fine too, but yeah, you might as well 
use SG_IO at that point. All of my issues are all about filesystems.

And filesystems is where people use O_DIRECT most. Almost nobody puts 
their database on a partition of its own these days, afaik. Perhaps for 
benchmarking or some really high-end stuff. Not "normal users".

		Linus

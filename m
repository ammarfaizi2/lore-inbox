Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWCGDLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWCGDLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWCGDLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:11:03 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47798
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932638AbWCGDLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:11:01 -0500
Date: Mon, 06 Mar 2006 19:11:20 -0800 (PST)
Message-Id: <20060306.191120.58661202.davem@davemloft.net>
To: bcrl@kvack.org
Cc: da-x@monatomic.org, drepper@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060307020736.GW20768@kvack.org>
References: <20060307013915.GU20768@kvack.org>
	<20060307020411.GA21626@localdomain>
	<20060307020736.GW20768@kvack.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin LaHaise <bcrl@kvack.org>
Date: Mon, 6 Mar 2006 21:07:36 -0500

> On Tue, Mar 07, 2006 at 04:04:11AM +0200, Dan Aloni wrote:
> > This somehow resembles the scatter-gatter lists already used in some 
> > subsystems such as the SCSI sg driver. 
> 
> None of the iovecs are particularly special.  What's special here is that 
> particulars of the container make the fast path *cheap*.

Please read Druschel and Peterson's paper on fbufs and any followon
work before going down this path.  Fbufs are exactly what you are
proposing as a workaround for the VM cost of page flipping, and the
idea has been around since 1993. :-)

As I mentioned Chapter 5 of Networking Algorithmics discusses this
in detail, and also covers many related attempts such as I/O
Lite.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVISGbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVISGbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVISGbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:31:16 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:8303 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932334AbVISGbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:31:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=DGKzQYNpzPhgecWMwkSon+hc+OGY62lgCT3rx7+gCLn5EvqLTNTKtpo+eNOgcIdzxI/QR2DVSs/4cBe3n4TsEvASmb1DnNAZo8o/Vu3iuGftPcLoaUHq6Hk7bm1HOad3ZxgFpQ6rUPOC/UsOqlWdrNl9aGgl97Xe+vLAxH5xepc=  ;
Subject: Re: workaround large MTU and N-order allocation failures
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Dan Aloni <da-x@monatomic.org>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
In-Reply-To: <20050918143526.GA24181@localdomain>
References: <20050918143526.GA24181@localdomain>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 16:31:02 +1000
Message-Id: <1127111462.5272.7.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-18 at 17:35 +0300, Dan Aloni wrote:
> Hello,
> 
> Is there currently a workaround available for handling large MTU 
> (larger than 1 page, even 2-order) in the Linux network stack?
> 
> The problem with large MTU is external memory fragmentation in
> the buddy system following high workload, causing alloc_skb() to 
> fail.
> 
> I'm interested in patches for both 2.4 and 2.6 kernels.
> 

Yes there is currently a workaround. That is to keep increasing
/proc/sys/vm/min_free_kbytes until your allocation failures stop.

Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 

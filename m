Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVIROcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVIROcV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVIROcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:32:21 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:40153 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932089AbVIROcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:32:19 -0400
Date: Sun, 18 Sep 2005 17:35:26 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: workaround large MTU and N-order allocation failures
Message-ID: <20050918143526.GA24181@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there currently a workaround available for handling large MTU 
(larger than 1 page, even 2-order) in the Linux network stack?

The problem with large MTU is external memory fragmentation in
the buddy system following high workload, causing alloc_skb() to 
fail.

I'm interested in patches for both 2.4 and 2.6 kernels.

Thanks,

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net

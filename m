Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVFCSoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVFCSoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVFCSoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:44:07 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15309
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261497AbVFCSn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:43:56 -0400
Date: Fri, 03 Jun 2005 11:43:31 -0700 (PDT)
Message-Id: <20050603.114331.85417605.davem@davemloft.net>
To: haveblue@us.ibm.com
Cc: mbligh@mbligh.org, nickpiggin@yahoo.com.au, jschopp@austin.ibm.com,
       mel@csn.ul.ie, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy
 Version 12
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1117816980.5985.17.camel@localhost>
References: <429FFC21.1020108@yahoo.com.au>
	<369850000.1117807062@[10.10.2.4]>
	<1117816980.5985.17.camel@localhost>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 03 Jun 2005 09:43:00 -0700

> Are those loopback allocations GFP_KERNEL?

It depends :-)  Most of the time, the packets will be
allocated at sendmsg() time for the user, and thus GFP_KERNEL.

But the flags may be different if, for example, the packet
is being allocated for the NFS client/server code, or some
asynchronous packet generated at software interrupt time
(TCP ACKs, ICMP replies, etc.).

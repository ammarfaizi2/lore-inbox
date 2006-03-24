Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWCXO7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWCXO7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWCXO7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:59:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:61386 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932493AbWCXO7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:59:36 -0500
Date: Fri, 24 Mar 2006 20:29:12 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: jamal <hadi@cyberus.ca>
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink interface for delay accounting
Message-ID: <20060324145912.GB7495@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1142296834.5858.3.camel@elinux04.optonline.net> <1142297791.5858.31.camel@elinux04.optonline.net> <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2> <20060322074922.GA1164@in.ibm.com> <1143122686.5186.27.camel@jzny2> <20060324013229.GD13159@in.ibm.com> <1143209518.5076.21.camel@jzny2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143209518.5076.21.camel@jzny2>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 09:11:58AM -0500, jamal wrote:
> On Fri, 2006-24-03 at 07:02 +0530, Balbir Singh wrote:
> > On Thu, Mar 23, 2006 at 09:04:46AM -0500, jamal wrote:
> 
> > 3. nlmsg_new() now allocates for 2*u32 + sizeof(taskstats)
> 
> Not the right size; the u32 covers the V part of TLV. The T = 16 bits
> and L = 16 bits. And if you nest TLVs, then it gets more interesting.
> 
> Look at using proper macros instead of hard coding like you did.
> grep for something like RTA_SPACE and perhaps send a patch to make it
> generic for netlink.h
> 
> cheers,
> jamal
>

My bad,  but I was wondering why my test case did not segfault until
I saw the implementation of nlmsg_new :-)

I will fix this and use nla_total_size() to calculate the correct sizes
including padding and TLV.

Thanks again,
Balbir

 

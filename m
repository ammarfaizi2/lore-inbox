Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270015AbUJHQqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270015AbUJHQqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270019AbUJHQqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:46:44 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:45985 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S270015AbUJHQqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:46:42 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [RFC PATCH] scheduler: Dynamic sched_domains
Date: Fri, 8 Oct 2004 09:43:21 -0700
User-Agent: KMail/1.7
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, colpatch@us.ibm.com,
       pj@sgi.com, mbligh@aracnet.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       simon.derr@bull.net, frankeh@watson.ibm.com, hawkes@sgi.com
References: <1097110266.4907.187.camel@arrakis> <20041008.145516.26538192.t-kochi@bq.jp.nec.com> <41662EC8.4040308@yahoo.com.au>
In-Reply-To: <41662EC8.4040308@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410080943.21326.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 7, 2004 11:08 pm, Nick Piggin wrote:
> Takayoshi Kochi wrote:
> > Yup, if SD_NODES_PER_DOMAIN is set to 4, our 32-way TX-7 have
> > two disjoint domains ;(
> > (though the current default is 6 for ia64...)
> >
> > I think the default configuration of the scheduler domains should be
> > as identical to its real hardware topology as possible, and should
> > modify the default only when necessary (e.g. for Altix).
>
> That is the idea. Unfortunately the ia64 modifications are ia64 wide.
> I don't think it should be too hard to make it sn2 only.

The NEC and Altix machines both use a SLIT table to describe the machine 
layout, so it should be possible to build them correctly w/o special case 
code (I hope).  The question is how big to make them, but if that's runtime 
changeable, then no big deal.  Like I said, the main thing missing from my 
changes is a system wide domain, but I think John has some ideas about that.

Jesse


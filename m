Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVANIKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVANIKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 03:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVANIKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 03:10:44 -0500
Received: from canuck.infradead.org ([205.233.218.70]:32778 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261702AbVANIKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 03:10:35 -0500
Subject: RE: NUMA or not on dual Opteron
From: Arjan van de Ven <arjan@infradead.org>
To: davids@webmaster.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEGKBBAB.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKEEGKBBAB.davids@webmaster.com>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 09:10:27 +0100
Message-Id: <1105690227.6080.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 00:04 -0800, David Schwartz wrote:
> > In article <20050113094537.GB2547@favonius> you wrote:
> 
> > > I was under the impression that NUMA is useful on > 2-way systems only.
> > > Is this true, and if not, under what circumstances is NUMA useful on
> > > 2-way Opteron systems?
> 
> > NUMA is good for all situations where you have more than one CPU and the
> > CPUs have different access speeds for some parts of the memory (i.e. cpu
> > local memory). This is true for SMP Opterons, not for the usual Intel
> > Boards.
> 
> 	Not quite. It's good if and only if the NU of the MA is sufficient to
> overcome the overhead associated with the NUMA code. Whether or not this is
> true depends upon two factors:
> 
> 	1) How non-uniform is the memory access? On 2 CPU Opteron systems, the
> answer is generally not very at all, it's nearly uniform.
> 
> 	2) How much overhead does the NUMA code add? On most of the benchmarks I've
> seen, the answer is a lot, so much that the memory access would have to be
> very non-uniform (factor of 2 at least) to justify enabling the NUMA code.

btw one of the major "pain points" of numa is that there are more memory
zones, and thus making it harder on the vm to balance the memory between
them...



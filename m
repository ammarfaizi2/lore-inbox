Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVJLJFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVJLJFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 05:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVJLJFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 05:05:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12932 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932415AbVJLJFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 05:05:42 -0400
Subject: Re: using segmentation in the kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Brian Gerst <bgerst@didntduck.org>,
       "Jonathan M. McCune" <jonmccune@cmu.edu>, linux-kernel@vger.kernel.org,
       Arvind Seshadri <arvinds@cs.cmu.edu>, Bryan Parno <parno@cmu.edu>
In-Reply-To: <434C1F8E.6080405@gmail.com>
References: <434C1D60.2090901@cmu.edu> <434C2269.5090209@didntduck.org>
	 <434C1F8E.6080405@gmail.com>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 11:05:35 +0200
Message-Id: <1129107936.3082.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 22:24 +0200, Alon Bar-Lev wrote:
> Brian Gerst wrote:
> > Jonathan M. McCune wrote:
> > 
> >> Hello,
> >>
> > Why send the kernel back to the 2.0 days?  There is no valid reason for 
> > doing this with they way x86 segmentation works, which is why it was 
> > done away with in 2.1.
> > 
> 
> But with segmentation you can set code to be read-only, 

you can do that without segmentation too, absolutely no problem

> disallow execution from stack,

That is why CPUs have NX nowadays. And it's not like the kernel is full
of buffer overflows; due to the 4Kb stack space (total), there are very
very few static buffers on the stack at all; simply because theres no
space to do it.

>  separate modules so that they 
> will not affect kernel and more...

and I don't believe this one yota. THe only way to do this is to run
modules in ring 1, at which point you are in deep shit anyway.




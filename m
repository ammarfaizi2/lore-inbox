Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUCEBT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 20:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbUCEBT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 20:19:28 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:17602 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262154AbUCEBT1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 20:19:27 -0500
Date: Thu, 4 Mar 2004 17:19:26 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: James Morris <jmorris@redhat.com>, Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
In-Reply-To: <20040304132430.GA8213@certainkey.com>
Message-ID: <Pine.LNX.4.58.0403041702180.794@twinlark.arctic.org>
References: <20040220172237.GA9918@certainkey.com>
 <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com>
 <20040221164821.GA14723@certainkey.com> <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org>
 <20040303150647.GC1586@certainkey.com> <Pine.LNX.4.58.0403031735210.26196@twinlark.arctic.org>
 <20040304132430.GA8213@certainkey.com>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Jean-Luc Cooke wrote:

> recommend using a MAC with CTR.  (Why still have CTR?  Unlike CBC, you can
> compute the N+1-th block without needing to know the output from the N-th
> block, so there is the possibility for very high parallelizum).

for disk crypto there are other opportunities for parallelism using
bitslicing to encrypt/decrypt multiple blocks in parallel (for example see
<http://www.cs.utexas.edu/users/atri/papers/spaa.ps>).  there's a
latency/throughput tradeoff though...

-dean

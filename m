Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVFKOiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVFKOiy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVFKOiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:38:54 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:19980 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261715AbVFKOiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:38:50 -0400
Date: Sat, 11 Jun 2005 16:38:41 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alastair Poole <alastair@unixtrix.com>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: BUG: Unusual TCP Connect() results.
Message-ID: <20050611143841.GA1851@alpha.home.local>
References: <42A8ABDB.6080804@unixtrix.com> <42A9B193.1020602@stud.feec.vutbr.cz> <42A9C607.4030209@unixtrix.com> <42A9BA87.4010600@stud.feec.vutbr.cz> <20050610222645.GA1317@pcw.home.local> <42AB046D.1020607@unixtrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AB046D.1020607@unixtrix.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 03:34:05PM +0000, Alastair Poole wrote:
> Should something be down to change this new behaviour to that of older 
> kernels?  Or is this a feature that should stay?
 
As David said, the simultaneous connect has always been there. The new
behaviour you observe might be the fact that the source port allocator
sometimes returns an address which is identical to the destination, and
that can seem somewhat strange. But I don't know if it's a new behaviour
or if it never showed up before because of race conditions.

Willy


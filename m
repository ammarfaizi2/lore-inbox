Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVDGWvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVDGWvQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 18:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVDGWtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 18:49:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:50910 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262621AbVDGWsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 18:48:42 -0400
Subject: Re: [PATCH] radeonfb: (#2)  Implement proper workarounds for PLL
	accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <jehdii8hjk.fsf@sykes.suse.de>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	 <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	 <1112827655.9518.194.camel@gaston>  <jehdii8hjk.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 08:47:31 +1000
Message-Id: <1112914051.9518.306.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 22:21 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > It is weird tho. Could you try adding a printk or something to figure
> > out how much this is called during a typical swich ?
> 
> There are 1694 calls to radeon_pll_errata_after_data during a switch from
> X to the console and 393 calls the other way.

Wow ! That is plain wrong !

Can you cound how many times radeonfb_set_par is called and dump your
"counter" at the beginning and end of each of these calls ?

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbTJWL1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 07:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263534AbTJWL1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 07:27:46 -0400
Received: from intra.cyclades.com ([64.186.161.6]:63918 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263532AbTJWL1p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 07:27:45 -0400
Date: Thu, 23 Oct 2003 09:24:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Linus Torvalds <torvalds@osdl.org>
Cc: "M.H.VanLeeuwen" <vanl@megsinet.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [BUG somewhere] 2.6.0-test8 irq.c, IRQ_INPROGRESS ?
In-Reply-To: <Pine.LNX.4.44.0310222021410.3151-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0310230913220.1443-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Oct 2003, Linus Torvalds wrote:

> 
> On Wed, 22 Oct 2003, M.H.VanLeeuwen wrote:
> > 
> > I'm seeing an NMI Watchdog detected LOCKUP go away when I revert this patch
> > previously added into test8.
> 
> Yes, the thing is buggy. 
> 
> It's not correct for "disable_irq_nosync()" users, and reverting it is the 
> right thing to do. Thanks for the report.
> 
> Marcelo, please note if you played with this in 2.4.x..

2.4.23-pre8 does clear IRQ_INPROGRESS in setup_IRQ() (it fixes the IDE setup
hang viro mentioned). 

disable_irq_nosync() doesnt care about IRQ_INPROGRESS. I cant figure out why 
does the change breaks...
 





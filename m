Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271223AbTG2Bni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 21:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271224AbTG2Bni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 21:43:38 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:1028
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S271223AbTG2Bnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 21:43:37 -0400
Date: Mon, 28 Jul 2003 03:40:11 -0600 (CST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: tmolina@cablespeed.com
Subject: Re: Presario oops on 2.6.0-test1
In-Reply-To: <Pine.LNX.4.44.0307250518230.822-100000@lap>
Message-ID: <Pine.LNX.4.44.0307280338390.821-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003, Thomas Molina wrote:

> > It gives me Unable to handle kernel paging request at virtual address
> > c035800
> > *pde = 00102027
> > *pte = 00358000
> >
> > Oops: 0000[#1]
> > CPU:    0
> > EIP:    0060:[<C014CE95>]    Not tainted
> > EFLAGS: 00010002
> > EIP is at store_stackinfo+0x85/0xc0
> 
> 
> I have an update to this.  I went back and tested various kernel 
> revisions.  The above panic started happening in 2.5.74-bk1.  This appears 
> to be where the store_stackinfo function was added, protected by 
> CONFIG_DEBUG_PAGEALLOC.  Sure enough, building a 2.6.0-test1 with the same 
> configuration minus page allocation debugging produces a kernel which 
> boots without the above panic.  However, now I get the following oops, 
> which at least makes it into the message log.  This oops happens during 
> bootup, followed a minute or two later by a followon oops which I am 
> unable to capture.  The oops does not happen with every boot 
> unfortunately.

This behaviour continues with 2.6.0-test2.  This has been filed in 
Bugzilla as bug number 973.


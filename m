Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbWCUU7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWCUU7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWCUU7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:59:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965110AbWCUU7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:59:11 -0500
Date: Tue, 21 Mar 2006 12:59:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sander <sander@humilis.net>
cc: Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
In-Reply-To: <20060321204435.GE25066@favonius>
Message-ID: <Pine.LNX.4.64.0603211249270.3622@g5.osdl.org>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca>
 <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca>
 <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org>
 <20060321191547.GC20426@favonius> <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org>
 <20060321204435.GE25066@favonius>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Sander wrote:
> 
> Is there a quick patch to suspect, or should I narrow down some more per
> Andrew's instructions?

Well, the only thing that changes the sata_mv driver in the -mm1 patchset 
is the "git-libata-all.patch" patch, so you might start out just applying 
that one broken-out patch and verifying that it fixes things for you.

That's git commit 2086a4aa2b41846801fad01f0fb1723134865ebb from Jeff's 
libata tree.

At that point, if that fixes it for you, you'd be best off bisecting it in 
Jeff's libata tree using git, to figure out what it is that fixed things. 
Jeff?

		Linus

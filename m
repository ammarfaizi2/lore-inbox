Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTKLEgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 23:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTKLEgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 23:36:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32713 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261368AbTKLEgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 23:36:22 -0500
Date: Wed, 12 Nov 2003 04:36:20 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Daniel Craig <dancraig@internode.on.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-bk16 ALi M5229 kernel boot error
Message-ID: <20031112043620.GE24159@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0311111901490.1694-100000@home.osdl.org> <3FB1ADEC.80600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB1ADEC.80600@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 10:50:04PM -0500, Jeff Garzik wrote:
> >-	if (north && north->vendor != PCI_VENDOR_ID_AL) {
> >+	if (!isa_dev) {
> > 		local_irq_restore(flags);
> > 	        return 0;
> 
> 
> For a little bit of history, this 'if' test succeeds on Alpha.  We 
> return here on Alpha to avoid x86-specific stuff.

... on _some_ alphas.
 
> Al, any chance you could test Linus's patch?  It hinges on whether the 
> Alpha will match the southbridge (isa_dev), rather than the northbridge. 
>  This seems like a safe bet, but better to test and be sure...

DS10 here actually has Ali southbridge and it has nothing on 0.0.0, so
it won't make any difference on this box - neither condition is met.

And UP1000 box (also 1533/5229) has faulty DMA on the southbridge - even
for floppy, so it's useless for such testing.

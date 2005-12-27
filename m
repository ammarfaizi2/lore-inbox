Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVL0JJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVL0JJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 04:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVL0JJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 04:09:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:23765 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932275AbVL0JJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 04:09:43 -0500
Subject: Re: [BUG] Xserver startup locks system... git bisect results
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Will Dyson <will.dyson@gmail.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>,
       Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <8e6f94720512262348l698c6cfbs28841f3f1dc989f1@mail.gmail.com>
References: <20051215043212.GA4479@jupiter.solarsys.private>
	 <1134622384.16880.26.camel@gaston> <1134623242.16880.30.camel@gaston>
	 <1134623748.16880.32.camel@gaston>
	 <17313.12671.661715.211100@cargo.ozlabs.ibm.com>
	 <20051216035032.GA4026@jupiter.solarsys.private>
	 <1134712343.6316.2.camel@gaston>
	 <8e6f94720512262348l698c6cfbs28841f3f1dc989f1@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 20:09:20 +1100
Message-Id: <1135674561.4780.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 02:48 -0500, Will Dyson wrote:
> On 12/16/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > Finally fixes the radeon memory mapping bug that was incorrectly
> > fixed by the previous patch. This time, we use the actual vram
> > size as the size to calculate how far to move the AGP aperture
> > from the framebuffer in card's memory space. If there are still
> > issues with this patch, they are due to bugs in the X driver that
> > I'm working on fixing too.
> 
> My amd64 machine with an agp radeon9200SE locks up tight on xserver
> start (with an MCE) unless I revert both patches. I'm using x.org 6.9
> compiled from the debian svn tree. The output of 'lspci -vv' is
> available here:
> 
> http://www.lucidts.com/~will/lspcivv.txt
> 
> Please let me know of any testing I can do on x.org radeon DDX
> patches, or any additional information I can provide.

Can you try the additional patch I sent ? If it doesn't help, I'll try
to send later today or tomorow a patch adding more debug informations so
I can figure out what's going on...

Ben.



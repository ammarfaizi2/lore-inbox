Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUH2MBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUH2MBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 08:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUH2MB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 08:01:29 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:50936 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267760AbUH2MB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 08:01:28 -0400
Message-ID: <28153.203.122.194.204.1093780887.squirrel@www.csn.ul.ie>
In-Reply-To: <20040829125319.A22787@infradead.org>
References: <Pine.LNX.4.58.0408291220330.11976@skynet>
    <1093779603.2792.19.camel@laptop.fenrus.com>
    <20040829125319.A22787@infradead.org>
Date: Sun, 29 Aug 2004 13:01:27 +0100 (IST)
Subject: Re: [bk pull] DRM tree - stop i830/i915 in kernel
From: "Dave Airlie" <airlied@linux.ie>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Arjan van de Ven" <arjanv@redhat.com>, "Dave Airlie" <airlied@linux.ie>,
       torvalds@osdl.org, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> It just disables to have both builtin, no both modular.  So it shouldn't
> be a problem for you, but I wonder what the point is..

they both work with the exact same hardware, when X starts up it traverses
the loaded DRMs asking for them by PCI ID, as both these drivers live on
the same set of PCIIDs (well the 915 has some new ones), X doesn't know
how to distinguish between them, so it picks the first one that says that
PCI ID is me, and in X.org with the i915 it picks the i830 driver and it
gets a bit shirty..

I suppose Tungsten Graphics could have done something extra (the famous
layer of indirection type stuff) but believed a clean breaak was best...

This patch just stops people shooting themselves in the foot ....

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@linux.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


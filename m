Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUA2Qxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUA2Qxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:53:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:10156 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266245AbUA2QxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:53:11 -0500
Date: Thu, 29 Jan 2004 08:52:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <willy@debian.org>
cc: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, Andi Kleen <ak@colin2.muc.de>,
       Andrew Morton <akpm@osdl.org>, mj@ucw.cz,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
In-Reply-To: <20040129164230.GE18725@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0401290850360.689@home.osdl.org>
References: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com>
 <20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk>
 <20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0401290802370.689@home.osdl.org>
 <20040129164230.GE18725@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jan 2004, Matthew Wilcox wrote:
> 
> Ahh, I missed the comment towards the top of fixmap.h that this is a
> constant address.  You're so smart sometimes ;-)

Hey, you'd better verify that the compiler doesn't do anything stupid (but
the good news is that if it doesn't inline the thing properly and do all
the constant folding, you should get a link-time failure about
"__this_fixmap_does_not_exist", so we should be fairly safe).

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVBQRh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVBQRh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVBQReG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:34:06 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:28352 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262314AbVBQRc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:32:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mQvE3dXmKoFtmVY4aPXQzt63fc8SNtJmOvKLFBwWvi2BBauvZJnTwB6RpXl6IOmcEB9iA6NLZzLCcL4W8NQRPKvjFu9/mPRSWbORLm0Ky2LKcfCgX04S2eUCIe6O6RTxKI7lqZzZRhEfGmzChK/H2xHZjo1rtE1d2GB6qllc8Cw=
Message-ID: <9e47339105021709321dc72ab2@mail.gmail.com>
Date: Thu, 17 Feb 2005 12:32:57 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200502170929.54100.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502151557.06049.jbarnes@sgi.com>
	 <1108601294.5426.1.camel@gaston>
	 <9e473391050217083312685e44@mail.gmail.com>
	 <200502170929.54100.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005 09:29:53 -0800, Jesse Barnes <jbarnes@sgi.com> wrote:
> On Thursday, February 17, 2005 8:33 am, Jon Smirl wrote:
> > > No, pci_map_rom shouldn't test the signature IMHO. While PCI ROMs should
> > > have the signature to be recognized as containing valid firmware images
> > > on x86 BIOSes an OF, it's just a convention on these platforms, and I
> > > would rather let people put whatever they want in those ROMs and still
> > > let them map it...
> >
> > pci_map_rom will return a pointer to any ROM it finds. It the
> > signature is invalid the size returned will be zero. Is this ok or do
> > we want it to do something different?
> 
> Shouldn't it return NULL if the signature is invalid?
> 

But then you couldn't get to your non-standard ROMs

> Jesse
> 


-- 
Jon Smirl
jonsmirl@gmail.com

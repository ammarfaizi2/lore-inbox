Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVBQRbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVBQRbD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVBQRbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:31:03 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:35044 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262313AbVBQRa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:30:58 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Date: Thu, 17 Feb 2005 09:29:53 -0800
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200502151557.06049.jbarnes@sgi.com> <1108601294.5426.1.camel@gaston> <9e473391050217083312685e44@mail.gmail.com>
In-Reply-To: <9e473391050217083312685e44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502170929.54100.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 17, 2005 8:33 am, Jon Smirl wrote:
> > No, pci_map_rom shouldn't test the signature IMHO. While PCI ROMs should
> > have the signature to be recognized as containing valid firmware images
> > on x86 BIOSes an OF, it's just a convention on these platforms, and I
> > would rather let people put whatever they want in those ROMs and still
> > let them map it...
>
> pci_map_rom will return a pointer to any ROM it finds. It the
> signature is invalid the size returned will be zero. Is this ok or do
> we want it to do something different?

Shouldn't it return NULL if the signature is invalid?

Jesse

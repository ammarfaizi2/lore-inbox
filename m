Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTJXBw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 21:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTJXBw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 21:52:28 -0400
Received: from web14905.mail.yahoo.com ([216.136.225.57]:20499 "HELO
	web14905.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261938AbTJXBw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 21:52:26 -0400
Message-ID: <20031024015224.54982.qmail@web14905.mail.yahoo.com>
Date: Thu, 23 Oct 2003 18:52:24 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>,
       kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
In-Reply-To: <3F987E18.9080606@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Video drivers only enable the ROM long enough to get some values out it and
then disable it. You don't want to leave ROMs enabled because there is some
hardware that uses the same address decoder for ROM and RAM and you can't use
them both at the same time.

--- Jeff Garzik <jgarzik@pobox.com> wrote:
> Linus Torvalds wrote:
> > [ Jeff: is that PCI ROM enable _really_ that complicated? Ouch. Or is
> >   there some helper function I missed? ]
> 
> 
> The mechanics aren't complicated, but I seem to recall there being a 
> Real Good Reason why you want to leave it disabled 99% of the time.  No, 
> I don't recall that reason :(  But my fuzzy memory seems to think that 
> "enable, grab a slice o 'rom, disable" was viable.
> 
> 	Jeff
> 
> 
> 


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com

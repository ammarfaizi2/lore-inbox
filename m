Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290675AbSBFQzA>; Wed, 6 Feb 2002 11:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290669AbSBFQyu>; Wed, 6 Feb 2002 11:54:50 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:7673 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290665AbSBFQyn>;
	Wed, 6 Feb 2002 11:54:43 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15457.24490.49714.443106@napali.hpl.hp.com>
Date: Wed, 6 Feb 2002 08:54:02 -0800
To: Christoph Hellwig <hch@caldera.de>
Cc: David Mosberger <davidm@hpl.hp.com>,
        Michael Madore <mmadore@turbolinux.com>, linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
In-Reply-To: <20020206092129.A8739@caldera.de>
In-Reply-To: <3C6043E5.D1F40E5D@turbolinux.com>
	<20020205223804.A22012@caldera.de>
	<15456.21030.840746.209377@napali.hpl.hp.com>
	<20020206092129.A8739@caldera.de>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 6 Feb 2002 09:21:29 +0100, Christoph Hellwig <hch@caldera.de> said:

  Christoph> On Tue, Feb 05, 2002 at 01:44:06PM -0800, David Mosberger
  Christoph> wrote: IA64 needs to define dma64_addr_t.

  >>  Not before the driver writers understand when to use it.

  Christoph> Architecture maintainers are not supposed to decide
  Christoph> whether driver writers understand APIs.  The dma64_addr_t
  Christoph> type is part of the PCI DMA interface and IA64 needs to
  Christoph> defines it.

Then find a better way to catch errant uses of dma64_addr_t.  I have
spent too much time discussing the DMA API with Dave M to see it being
misused for no good reason.  It will take some time until there are
enough sample drivers that show proper usage of the DMA interface.
There is almost no driver that needs dma64_addr_t.  We can add it
once there is an ia64 driver that *really* needs it.

  Christoph> Linus, could you please accept the below patch to define
  Christoph> dma64_addr_t on IA64?

Christoph, if you want this type your linux distro, you can add it
with your own patch.  For the time being, I'm the ia64 linux
maintainer so I hope you can respect my decisions.

	--david

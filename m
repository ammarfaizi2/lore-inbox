Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264816AbRF1WtC>; Thu, 28 Jun 2001 18:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264812AbRF1Wsx>; Thu, 28 Jun 2001 18:48:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20382 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264803AbRF1Wsl>;
	Thu, 28 Jun 2001 18:48:41 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15163.46150.164836.342792@pizda.ninka.net>
Date: Thu, 28 Jun 2001 15:48:38 -0700 (PDT)
To: Ben LaHaise <bcrl@redhat.com>
Cc: Jes Sorensen <jes@sunsite.dk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
 achi ne
In-Reply-To: <Pine.LNX.4.33.0106281840330.32276-100000@toomuch.toronto.redhat.com>
In-Reply-To: <15163.45534.977835.569473@pizda.ninka.net>
	<Pine.LNX.4.33.0106281840330.32276-100000@toomuch.toronto.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben LaHaise writes:
 > > How do you represent this with the undocumented API ia64 has decided
 > > to use?  You can't convey this information to the driver, because the
 > > driver may say "I don't care if it's slower, I want the large
 > > addressing because otherwise I'd consume or overflow the IOMMU
 > > resources".  How do you say "SAC is preferred for performance" with
 > > ia64's API?  You can't.
 > 
 > How is SAC useful on ia64?  All the machines are going to be shipped with
 > more than 4GB of RAM, and they need an IOMMU.

That is all that some devices are able to do, especially sound
cards, some of which even have < 32-bit addressing limitations.
ia64 supports such devices just fine, I know it does, else you
couldn't stick an eepro100 into an ia64 box running Linux :-)

There is a software IOMMU implemented in the ia64 port, and it
handles such SAC situations today.

 > Like it or not, 64 bit DMA is here, NOW.  Not during the 2.6, but during
 > 2.4.  We can either start fixing the ia64 APIs and replacing them with
 > something that's "Right" or we can continue with ad hoc solutions.

It will be fixed in 2.5.x and backported perhaps to 2.4.x, 2.4.x is
not a place for API experimentation.

Later,
David S. Miller
davem@redhat.com

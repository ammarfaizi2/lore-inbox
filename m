Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263293AbVCKClk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbVCKClk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbVCKCli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:41:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:11735 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263293AbVCKClK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:41:10 -0500
Subject: Re: AGP bogosities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jones <davej@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050311021248.GA20697@redhat.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <20050311021248.GA20697@redhat.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 13:35:40 +1100
Message-Id: <1110508541.32525.314.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> This part I'm not so sure about.
> The pci_get_class() call a few lines above will get a refcount that
> we will now never release.

We will ... on the next loop iteration when we call pci_get_class again.

> Thanks for taking a look at this. The absense of hardware to test
> on means I pretty much rely on feedback from inclusion in -mm
> to hear about problems like this before it hits mainline.
> Unfortunatly, no-one with ppc64 tested it there it seems :-(

And ppc32, and probably others... I have seen AGP layed out differently
in quite a few cases....

Ben.




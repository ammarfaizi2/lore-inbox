Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268306AbUI3Iki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268306AbUI3Iki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 04:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268310AbUI3Iki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 04:40:38 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:49862 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268306AbUI3Ikg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 04:40:36 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 30 Sep 2004 10:27:48 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org, greg@kroah.com
Subject: Re: [PATCH 2.6.9-rc2-mm4 zr36120.c][5/8] Convert pci_find_device	to pci_dev_present
Message-ID: <20040930082748.GC20456@bytesex>
References: <19730000.1096496900@w-hlinder.beaverton.ibm.com> <1096496127.16721.10.camel@localhost.localdomain> <24740000.1096500358@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24740000.1096500358@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The whole driver is CONFIG_BROKEN anyway... I only verified my changes
> didn't add new compiler errors. What part should I remove? Just this check?

pci/quirks.c does these checks and sets the flags.
Replacing with a check for "pci_pci_problems & PCIPCI_TRITON" should do.

bttv does simliar things in bttv_check_chipset() (bttv-cards.c),
you might want to have a look there ...

  Gerd

-- 
return -ENOSIG;

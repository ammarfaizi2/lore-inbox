Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269021AbUIXWDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269021AbUIXWDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUIXWDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:03:46 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:38121 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269015AbUIXWDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:03:41 -0400
Subject: Re: [PATCH 2.6.9-rc2-mm2] Create new function to see if pci dev is
	present
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org, davej@codemonkey.org.uk, hpa@zytor.com
In-Reply-To: <20040924211912.GC7619@kroah.com>
References: <2480000.1095978400@w-hlinder.beaverton.ibm.com>
	 <20040924200231.A30391@infradead.org>  <20040924211912.GC7619@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096059645.10797.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 22:00:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-24 at 22:19, Greg KH wrote:
> > Please include subdevice/subvendor id
> 
> Good idea, but do you see any places in the kernel that would use those
> fields, instead of always setting them to PCI_ANY_ID?

If you are taking that path then make it take a pci_device_id table.
That makes it behave like other interfaces of the same form, and makes
the implementation remarkably trivial.


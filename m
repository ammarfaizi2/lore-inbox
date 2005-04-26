Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVDZEAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVDZEAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVDZEAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:00:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:27078 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261296AbVDZEAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:00:12 -0400
Subject: Re: [PATCH] PCI: Add pci shutdown ability
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Alexander Nyberg <alexn@dsv.su.se>, Amit Gud <gud@eth.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20050425201250.GB24433@kroah.com>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org>
	 <20050425182951.GA23209@kroah.com>
	 <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com>
	 <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com>
	 <1114458325.983.17.camel@localhost.localdomain>
	 <20050425201250.GB24433@kroah.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:59:10 +1000
Message-Id: <1114487950.7182.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-25 at 13:12 -0700, Greg KH wrote:

> People are starting to submit patches for pci drivers that add "reboot
> notifier" hooks, under the guise of fixing up kexec issues with those
> drivers.
> 
> That is why I proposed this patch, to make it easier for such drivers to
> shutdown properly, without needing a reboot notifier hook (which takes
> up more code and memory.

But it isn't the right fix. It should be a suspend() call with
PMSG_FREEZE

Ben.



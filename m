Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUHCAkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUHCAkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUHCAhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:37:41 -0400
Received: from the-village.bc.nu ([81.2.110.252]:30905 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264655AbUHCAep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:34:45 -0400
Subject: Re: [PATCH] add PCI ROMs to sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Jon Smirl <jonsmirl@yahoo.com>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408021405.15640.jbarnes@engr.sgi.com>
References: <20040802210048.5071.qmail@web14928.mail.yahoo.com>
	 <200408021405.15640.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091489519.1647.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 00:32:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-02 at 22:05, Jesse Barnes wrote:
> > Is tracking the boot video device and redirecting to C000:0 going to be
> > a quirk, architecture specific, or what? Where does this little piece
> > of code need to go?
> 
> I think that would be a quirk.  You'd copy ROMs like that into the rom pointer 
> in the pci_dev structure I guess.

Providing that quirk is scanned at hotplug time it can go into the quirk
code which is probably simplest. It may need a tiny hook in sysfs to map
the right object but that isnt hard.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVKFULS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVKFULS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 15:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKFULR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 15:11:17 -0500
Received: from [81.2.110.250] ([81.2.110.250]:48008 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750941AbVKFULR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 15:11:17 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131141030.29195.18.camel@gaston>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <1131086585.4680.235.camel@gaston>
	 <1131111297.26925.24.camel@localhost.localdomain>
	 <1131141030.29195.18.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 06 Nov 2005 20:41:31 +0000
Message-Id: <1131309691.1212.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-11-05 at 08:50 +1100, Benjamin Herrenschmidt wrote:
> OK, but my question why, what is the reason why we need IRQ mask ? Some
> old non-PCI controllers can't grok un-related ISA IO cycles during a
> FIFO read/write ? I suppose those would be broken on SMP too (though I
> suspect then that those don't exist as SMP machines then :)

There are PCI controllers that are hosed too. They incorrectly handle
the situation where the PCI fifo empties/fills and the controller should
indicate to the drive to stall the transfer. The chipsets I know that
are afflicted with this are all uniprocessor mainboard devices.

Alan


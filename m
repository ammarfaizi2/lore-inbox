Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267789AbUG3TFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267789AbUG3TFG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267796AbUG3TFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:05:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37598 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267791AbUG3TE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:04:59 -0400
Date: Fri, 30 Jul 2004 20:04:56 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730190456.GZ10025@parcelfarce.linux.theplanet.co.uk>
References: <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk> <20040730185921.99631.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730185921.99631.qmail@web14929.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 11:59:21AM -0700, Jon Smirl wrote:
> Alan Cox knows more about this, but I believe there is only one PCI
> card in existence that does this.

Strange; he was the one who pointed out this requirement to me in the
first place and he hinted that many devices did this.

> For the one or two cards that do this, the device drivers could flag
> this to the PCI subsystem. In the flagged case the sysfs read code
> could  shut off interrupts, enable the ROM, copy it, and then reenable
> interrupts. 

Shutting off interrupts isn't nearly enough.  Any other CPU could access the
device, or indeed any device capable of DMA could potentially cause trouble.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

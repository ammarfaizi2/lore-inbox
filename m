Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVAPCMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVAPCMN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVAPCIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:08:34 -0500
Received: from [81.2.110.250] ([81.2.110.250]:9603 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262392AbVAPCH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:07:29 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andi Kleen <ak@muc.de>, brking@us.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105770012.27411.72.camel@gaston>
References: <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>
	 <1105626399.4664.7.camel@localhost.localdomain>
	 <20050113180347.GB17600@muc.de>
	 <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de>
	 <1105645491.4624.114.camel@localhost.localdomain>
	 <20050113215044.GA1504@muc.de>
	 <1105743914.9222.31.camel@localhost.localdomain>
	 <20050115014440.GA1308@muc.de>
	 <1105750898.9222.101.camel@localhost.localdomain>
	 <1105770012.27411.72.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105829883.15835.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 00:58:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-15 at 06:20, Benjamin Herrenschmidt wrote:
> I'm pretty sure similar situations can happen on other archs when
> pushing a bit on power management, especially things like handhelds
> (though not much of them are PCI based for now).
> 
> That's why a "generic" mecanism to hide such devices while providing
> cached data on config space read's would be useful to me as well.

That makes a lot of sense. So we need both a "blocked, will be back
soon" and "this PCI device is invisible" flags. A device going into
blocked and not coming back would presumably transition into
"invisible".  I'm assuming we can't just delete the PCI device because
the kernel needs to know that cell is there for future use/abuse.


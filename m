Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVAPWHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVAPWHS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVAPWHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:07:18 -0500
Received: from colin2.muc.de ([193.149.48.15]:23816 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262624AbVAPWHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:07:15 -0500
Date: 16 Jan 2005 23:07:14 +0100
Date: Sun, 16 Jan 2005 23:07:14 +0100
From: Andi Kleen <ak@muc.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, brking@us.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050116220714.GA76666@muc.de>
References: <1105645491.4624.114.camel@localhost.localdomain> <20050113215044.GA1504@muc.de> <1105743914.9222.31.camel@localhost.localdomain> <20050115014440.GA1308@muc.de> <1105750898.9222.101.camel@localhost.localdomain> <1105770012.27411.72.camel@gaston> <1105829883.15835.6.camel@localhost.localdomain> <1105848104.27436.97.camel@gaston> <20050116044823.GA55143@muc.de> <1105908798.27436.102.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105908798.27436.102.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is complex in there ? I agree it's not convenient to do this from
> the very low level ones that don't take the pci_dev * as an argument,
> but from the higher level ones that does, the overhead is basically to
> test a flag in the pci_dev, I doubt it will be significant in any way
> performance wise, especially compared to the cost of a config space
> access...

For once you cannot block in them.  There are even setups that
need to (have to) do config space accesses in interrupt handlers.
The operations done there should be rather light weight.

-Andi

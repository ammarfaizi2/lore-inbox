Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVAPEs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVAPEs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 23:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVAPEs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 23:48:27 -0500
Received: from colin2.muc.de ([193.149.48.15]:43527 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262426AbVAPEsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 23:48:25 -0500
Date: 16 Jan 2005 05:48:23 +0100
Date: Sun, 16 Jan 2005 05:48:23 +0100
From: Andi Kleen <ak@muc.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, brking@us.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050116044823.GA55143@muc.de>
References: <1105641991.4664.73.camel@localhost.localdomain> <20050113202354.GA67143@muc.de> <1105645491.4624.114.camel@localhost.localdomain> <20050113215044.GA1504@muc.de> <1105743914.9222.31.camel@localhost.localdomain> <20050115014440.GA1308@muc.de> <1105750898.9222.101.camel@localhost.localdomain> <1105770012.27411.72.camel@gaston> <1105829883.15835.6.camel@localhost.localdomain> <1105848104.27436.97.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105848104.27436.97.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right. Though I think the "will be back soon" and "is invisible" are
> pretty much the same thing. That is, in both our cases (BIST and pmac
> PM), we want the device to still be visible to userland, as it actually
> exist, should be properly detected by userland config tools etc..., but
> may only be actually enabled when the interface is opened/used for PM
> reasons.

I just request that this shouldn't be done in the low level pci_config_read_*
functions. Please keep them simple and lean. If you want such complex 
semantics for user space do it in a separate layer.

-Andi

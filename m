Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWFQFF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWFQFF0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 01:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWFQFF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 01:05:26 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:25835 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1750814AbWFQFFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 01:05:25 -0400
Date: Fri, 16 Jun 2006 23:05:24 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Brice Goglin <brice@myri.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Message-ID: <20060617050524.GX2387@parisc-linux.org>
References: <4493709A.7050603@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4493709A.7050603@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 11:01:46PM -0400, Brice Goglin wrote:
> Several chipsets are known to not support MSI. Some support MSI but
> disable it by default. Thus, several drivers implement their own way to
> detect whether MSI works.

Yes, and that needs to go away.  To be fair, we're in the early stages
of introducing generic MSI support, so it's understandable that people
have made expedient rather than architectural solutions to problems.

> We introduce whitelisting of chipsets that are known to support MSI and
> keep the existing backlisting to disable MSI for other chipsets. When it
> is unknown whether the root chipset support MSI or not, we disable MSI
> by default except if pci=forcemsi was passed.

I think that's a bad idea.  Blacklisting is the better idea in the long-term.

> Bus flags inheritance is dropped since it has been reported to be broken.

I must have missed that report.  Please elucidate.


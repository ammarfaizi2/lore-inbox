Return-Path: <linux-kernel-owner+w=401wt.eu-S1752880AbXABXye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbXABXye (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbXABXye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:54:34 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47889 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbXABXyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:54:33 -0500
Message-ID: <459AF0B4.10509@pobox.com>
Date: Tue, 02 Jan 2007 18:54:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>
CC: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>	<459973F6.2090201@pobox.com>	<20070102115834.1e7644b2@localhost.localdomain>	<459AC808.1030807@pobox.com>	<20070102212701.4b4535cf@localhost.localdomain>	<459ACE9C.7020107@pobox.com>	<20070102224559.2089d28d@localhost.localdomain>	<459AE459.8030107@pobox.com> <20070102232706.49340349@localhost.localdomain>
In-Reply-To: <20070102232706.49340349@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or maybe this rephrase helps:

Regardless of how the IDE quirks have configured the PCI BARs, libata is 
written to assume that /all/ struct pci_dev resources for a single PCI 
device are reserved to the libata driver.

Thus, if you avoid calling pci_request_regions (as your patch does), you 
must manually provide the same guarantees that pci_request_regions 
provides to its callers.

	Jeff




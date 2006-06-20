Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWFTWq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWFTWq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWFTWq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:46:58 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:46364 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751446AbWFTWq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:46:57 -0400
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <gregkh@suse.de>, Dave Olson <olson@unixfolk.com>,
       discuss@x86-64.org, Brice Goglin <brice@myri.com>,
       linux-kernel@vger.kernel.org, Greg Lindahl <greg.lindahl@qlogic.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilitiesKJ
X-Message-Flag: Warning: May contain useful information
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no>
	<200606200925.30926.ak@suse.de> <20060620212908.GA17012@suse.de>
	<200606210033.35409.ak@suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 20 Jun 2006 15:46:55 -0700
In-Reply-To: <200606210033.35409.ak@suse.de> (Andi Kleen's message of "Wed, 21 Jun 2006 00:33:35 +0200")
Message-ID: <adasllzmom8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Jun 2006 22:46:56.0384 (UTC) FILETIME=[6EB5C800:01C694BB]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > NForce4 PCI Express is an unknown - we'll see how that works.

I have systems (HP DL145) with

    PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)

and MSI-X works fine for me with Mellanox PCIe adapters (with no
quirks or anything -- the BIOS enables it by default):

    $ grep MSI-X /proc/interrupts
     66:     205792          0          0          0       PCI-MSI-X ib_mthca (comp)
     74:          1          0          0          0       PCI-MSI-X ib_mthca (async)
     82:       1343          0          0          0       PCI-MSI-X ib_mthca (cmd)

 - R.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWFTUuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWFTUuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWFTUuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:50:51 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:63713 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751024AbWFTUuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:50:50 -0400
Message-ID: <44985F9A.6000108@myri.com>
Date: Tue, 20 Jun 2006 16:50:34 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: greg.lindahl@qlogic.com
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, ak@suse.de, olson@unixfolk.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com> <200606200925.30926.ak@suse.de> <20060620200352.GJ1414@greglaptop.internal.keyresearch.com> <20060620132049.ff5e6f67.rdunlap@xenotime.net> <20060620204109.GA1980@greglaptop.internal.keyresearch.com>
In-Reply-To: <20060620204109.GA1980@greglaptop.internal.keyresearch.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Lindahl wrote:
> Andi, is the tg3 NIC that didn't work in a Supermicro system
> on PCI-X or PCI Express?
>   

IIRC, Andi was talking about a Supermicro machine with a ServerWorks
HT2000 chipset. We have such a machine here. Its MSI is disabled in the
Hyper-transport mapping. But, MSI works once the HT capability is
enabled (and my quirk will detect it right).
For such machines, if people really want MSI, we'll need to enable the
HT cap in my quirk. But, as long as they just want IRQ to work,
detecting whether the HT cap is enabled or not should be enough.

Brice


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266256AbUHWRei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUHWRei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUHWReN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:34:13 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:60136 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266249AbUHWRan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:30:43 -0400
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: "cramerj" <cramerj@intel.com>, "Ronciak, John" <john.ronciak@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>,
       <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [broken?] Add MSI support to e1000
X-Message-Flag: Warning: May contain useful information
References: <C7AB9DA4D0B1F344BF2489FA165E50240619D5A0@orsmsx404.amr.corp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 23 Aug 2004 10:25:39 -0700
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E50240619D5A0@orsmsx404.amr.corp.intel.com> (Tom
 L. Nguyen's message of "Mon, 23 Aug 2004 08:41:06 -0700")
Message-ID: <52u0utvka4.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Aug 2004 17:25:40.0092 (UTC) FILETIME=[36078BC0:01C48936]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Tom> I do not see anything wrong with the patch and the kernel MSI
    Tom> support because it works for a short time. Ganesh may provide
    Tom> an answer on the MSI support in e1000 hardware.

Based on the e1000 documentation I have, the only thing required for
the e1000 to use MSI is to set the MSI enable bit in the PCI header.
Of course there may be some e1000 erratum involving MSI but I have not
been able to find any indication that this is the case.

It seems possible that there could be some problem in the core Linux
interrupt code even though some interrupts work -- for example there
could be a race condition triggered when a second interrupt is
delivered while handling the first interrupt.  However I couldn't find
any such bug, although I am not at all an expert about low-level
interrupt handling/APIC programming.

 - Roland

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUJJBia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUJJBia (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 21:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbUJJBia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 21:38:30 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:30426 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268025AbUJJBi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 21:38:28 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Richard Rosenberg <richrosenberg@earthlink.net>
X-Message-Flag: Warning: May contain useful information
References: <1097368522.1363.41.camel@krustophenia.net>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 09 Oct 2004 18:38:26 -0700
In-Reply-To: <1097368522.1363.41.camel@krustophenia.net> (Lee Revell's
 message of "Sat, 09 Oct 2004 20:35:23 -0400")
Message-ID: <52fz4nl5d9.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: weird APIC problem: irq 177 & irq 185
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 10 Oct 2004 01:38:27.0022 (UTC) FILETIME=[D6B546E0:01C4AE69]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Lee> There is no such thing as IRQ 177 and IRQ 185, correct?

With CONFIG_PCI_MSI (used to be CONFIG_PCI_USE_VECTOR) it's entirely
possible to get interrupt numbers like that.  On my dual Xeon system,
I have /proc/interrupts that looks like:

           CPU0       CPU1       CPU2       CPU3       
  0:  288964788          0          0          0    IO-APIC-edge  timer
  2:          0          0          0          0          XT-PIC  cascade
  4:        303          0          0          0    IO-APIC-edge  serial
 14:      67708          1          0          0    IO-APIC-edge  ide0
 15:         13          0          0          0    IO-APIC-edge  ide1
153:          0          0          0          0   IO-APIC-level  uhci_hcd
161:    1590294          0          0          0   IO-APIC-level  eth0
169:          0          0          0          0   IO-APIC-level  uhci_hcd
177:          0          0          0          0   IO-APIC-level  uhci_hcd
201:         81          0          0          0       PCI-MSI-X  ib_mthca (comp)
209:          2          0          0          0       PCI-MSI-X  ib_mthca (async)
217:       2171          0          0          0       PCI-MSI-X  ib_mthca (cmd)
NMI:   57794488   57794274   57794272   57794270 
LOC:  288981914  288981943  288981942  288981941 
ERR:          0
MIS:          0

 - Roland

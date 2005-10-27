Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbVJ0Tih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbVJ0Tih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 15:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbVJ0Tih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 15:38:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8938 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751570AbVJ0Tig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 15:38:36 -0400
Subject: Re: [patch 0/3] pci: store PCI_INTERRUPT_PIN in pci_dev
From: Arjan van de Ven <arjan@infradead.org>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com,
       len.brown@intel.com
In-Reply-To: <1130441405.5996.23.camel@whizzy>
References: <1130441405.5996.23.camel@whizzy>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 21:38:17 +0200
Message-Id: <1130441897.3027.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 12:30 -0700, Kristen Accardi wrote:
> Store the value of PCI_INTERRUPT_PIN in the pci_dev structure for use
> later.  This is useful for pci hotplug.  When a device is "surprise"
> removed, the pci config space is no longer available.  However,
> the pin value is needed to correctly disable the irq for the device.

Hmmm maybe it's just me..... but... isn't that both advisory and
entirely unrelated to any kind of real interrupt thing? Eg dev->irq is
there already and works even in the sight of IO-APICs etc etc...



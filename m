Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTKHURQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTKHURQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:17:16 -0500
Received: from main.gmane.org ([80.91.224.249]:14469 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262330AbTKHURP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:17:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [BK PATCHES] libata fixes
Date: Sat, 08 Nov 2003 23:16:55 +0300
Message-ID: <pan.2003.11.08.20.16.54.779374@altlinux.ru>
References: <20031108172621.GA8041@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Not about this particular libata update)

static void __init quirk_intel_ide_combined(struct pci_dev *pdev)
...
	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,
	  quirk_intel_ide_combined },

Won't this oops if some Intel device would be hotplugged?  A similar
problem with quirk_via_bridge was just fixed.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265228AbUFVS2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUFVS2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUFVSUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:20:08 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:15689 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265089AbUFVRxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:53:47 -0400
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <greg@kroah.com>
Subject: Re: [PATCH] Export msi_remove_pci_irq_vectors
X-Message-Flag: Warning: May contain useful information
References: <C7AB9DA4D0B1F344BF2489FA165E5024057E4EF2@orsmsx404.amr.corp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 22 Jun 2004 10:51:18 -0700
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024057E4EF2@orsmsx404.amr.corp.intel.com> (Tom
 L. Nguyen's message of "Tue, 22 Jun 2004 08:47:53 -0700")
Message-ID: <52hdt3o50p.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 17:51:18.0694 (UTC) FILETIME=[857F1460:01C45881]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Tom> The intent of msi_remove_pci_irq_vectors() is to support
    Tom> hot-removed operation. This function is not for a device
    Tom> driver to call and should not be exported. I acknowledged the
    Tom> problem of the MSI-X region being only released in
    Tom> msi_remove_pci_irq_vectors(). I'm in a progress of updating
    Tom> the existing MSI-X code.

Do you have any plans for when this should be fixed?  Right now, with
the standard kernel, if I unload and then reload my driver module,
setting up MSI-X fails the second time through because the core has
not cleaned up the memory region from the first time.

 - Roland

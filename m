Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVCKXK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVCKXK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVCKXHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:07:54 -0500
Received: from ozlabs.org ([203.10.76.45]:17572 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261799AbVCKW4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:56:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16946.8286.720245.664510@cargo.ozlabs.ibm.com>
Date: Sat, 12 Mar 2005 09:49:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: "Greg KH" <greg@kroah.com>, <benh@kernel.crashing.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI Express Advanced Error Reporting Driver
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024080392EC@orsmsx404.amr.corp.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024080392EC@orsmsx404.amr.corp.intel.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nguyen, Tom L writes:

> The standard PCI Specification calls out SERR and PERR. I am not sure
> about the recent discussion of PCI error of recovery. It is perhaps
> regarding the possibility of recovering from a PERR or SERR. However,
> PCI Express error occurs on the PCI Express link or on behalf of
> transactions occurred on the PCI Express link. PCI Express component,
> which implements PCI Express Advanced Error Reporting Capability, sends
> error message to the Root Port to indicate error occurred on the PCI
> Express link where it is connected. The PCI Express error recovery is on
> behalf of attempting to do a PCI Express link recovery, not PCI error
> recovery. It appears that PCI Express AER is disjoint from PCI error
> recovery.

To give you some context, the recent discussion was about how we could
give a unified interface to drivers for both PCI-Express error
reporting and for the "Enhanced Error Handling" (EEH) facilities we
have on IBM PPC64 boxes.  EEH includes not only the detection and
reporting of errors (for PCI, PCI-X and PCI-Express buses) but also
hardware support for isolating devices when an error is detected, plus
means for resetting individual bus segments or slots, to assist in
recovering a device which has got into a bad state.

Does PCI Express provide any facilities for recovering from errors,
beyond just "try that transaction again"?

Paul.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbULPRiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbULPRiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbULPRiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:38:20 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:50624 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261941AbULPRiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:38:08 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
Date: Thu, 16 Dec 2004 10:37:54 -0700
User-Agent: KMail/1.7.1
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, willy@debian.org
References: <200412160850.20223.jbarnes@engr.sgi.com>
In-Reply-To: <200412160850.20223.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412161037.55293.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 December 2004 9:50 am, Jesse Barnes wrote:
> This patch documents the /proc/bus/pci interface and adds some optional 
> architecture specific APIs for accessing legacy I/O port and memory space.  
> This is necessary on platforms where legacy I/O port space doesn't 'soft 
> fail' like it does on PCs, and is useful for systems that can route legacy 
> space to different PCI busses.

But we didn't resolve anything with respect to multiple PCI domains,
did we?  As far as I can see, /proc/bus/pci currently doesn't support
multiple domains at all.  I don't like the idea of adding new stuff
that we already know is insufficient for machines in the very near
future.  True, it's just extending an existing interface, but it
seems like if we're going to the trouble of changing X, we might as
well address multiple domains at the same time.

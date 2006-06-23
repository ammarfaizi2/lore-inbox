Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752035AbWFWUaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbWFWUaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbWFWUaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:30:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:33677 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752035AbWFWUav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:30:51 -0400
From: Andi Kleen <ak@suse.de>
To: rajesh.shah@intel.com
Subject: Re: [patch 2/2] x86_64 PCI: improve extended config space verification
Date: Fri, 23 Jun 2006 22:30:36 +0200
User-Agent: KMail/1.9.3
Cc: gregkh@suse.de, akpm@osdl.org, brice@myri.com, 76306.1226@compuserve.com,
       arjan@linux.intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
References: <20060623200928.036235000@rshah1-sfield.jf.intel.com> <20060623201601.752629000@rshah1-sfield.jf.intel.com>
In-Reply-To: <20060623201601.752629000@rshah1-sfield.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606232230.36579.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 June 2006 22:09, rajesh.shah@intel.com wrote:
> Extend the verification for PCI-X/PCI-Express extended config
> space pointer. This patch checks whether the MCFG address range
> is listed as a motherboard resource, per the PCI firmware spec.
> The old check only looked in int 15 e820 memory map, causing
> several systems to fail the verification and lose extended
> config space.

By adding so much code to it you volunteered to factor the 
sanity check into a common i386/x86-64 file first.

-Andi

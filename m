Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVCATSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVCATSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 14:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVCATSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 14:18:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:38549 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261996AbVCATSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 14:18:02 -0500
Date: Tue, 1 Mar 2005 13:17:54 -0600
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050301191754.GD1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com> <42249A44.4020507@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42249A44.4020507@pobox.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 11:37:24AM -0500, Jeff Garzik was heard to remark:
> 
> A new API handles none of this.

Seto is propsing an API that solves a different problem than what
you are thinking about.

In my case, the hardware (pci controller) will shut down a pci
slot(s) in the case of a pci error (parity or otherwise).  
There's nothing that the software can do except to reset
the pci controller (and the cards underneath it).

Seto's API solves 1/2 the problem for me: it allows errors
to be detected.  The other 1/2 (to be discussed) is how
to coordinate all the affected device drivers while the
pci controller is being reset.


--linas

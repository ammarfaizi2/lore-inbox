Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752649AbWKBEqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbWKBEqg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 23:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbWKBEqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 23:46:36 -0500
Received: from colo.lackof.org ([198.49.126.79]:17324 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1752441AbWKBEqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 23:46:35 -0500
Date: Wed, 1 Nov 2006 21:46:33 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20061102044633.GB23840@colo.lackof.org>
References: <20061020180510.GN6537@austin.ibm.com> <20061031185506.GE26964@parisc-linux.org> <20061031231334.GR6360@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031231334.GR6360@austin.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 05:13:34PM -0600, Linas Vepstas wrote:
...
> > Though, since INB and INW will return 0xff and 0xffff, why not use that
> > as our test rather than using a counter?
> 
> Right. I wanted to avoid checking for specific values, 
> as that vaguely seemed more robust; the direct check is easier.

ISTR some chipsets return 0 or the most recent data on the bus
when INB/INW master-abort.  Maybe this an ISA bus behavior?

Or is config space access the only space which behaves this way
for master abort on PCI?
I'm looking at drivers/pci/probe.c:pci_scan_device().

thanks,
grant

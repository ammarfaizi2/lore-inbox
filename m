Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWBYQN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWBYQN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWBYQN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:13:28 -0500
Received: from colo.lackof.org ([198.49.126.79]:35481 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1161017AbWBYQN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:13:27 -0500
Date: Sat, 25 Feb 2006 09:23:46 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "Grundler, Grant G" <grant.grundler@hp.com>,
       "Luck, Tony" <tony.luck@intel.com>, Chris Wedgwood <cw@f00f.org>,
       Grant Grundler <grundler@parisc-linux.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>
Subject: Re: Problems with MSI-X on ia64
Message-ID: <20060225162346.GA15372@colo.lackof.org>
References: <D4CFB69C345C394284E4B78B876C1CF10BAD8CA9@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10BAD8CA9@cceexc23.americas.cpqcorp.net>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 02:21:42PM -0600, Miller, Mike (OS Dev) wrote:
> So I looked at 2.6.16-rc3 which works in my lab, but phys_addr is still
> an int. How can that work?

"int" (u32) will work if the top bits are zero or alias to the
same thing as the full 64-bit address.
Can you apply the patch and add printk's to dump the
pci_resource_start(dev,bir) in msix_capability_init()?


> I believe Andrew saw the same thing in 2.6.15.

Yes, AFIACT 2.6.15 has the same code.

thanks,
grant

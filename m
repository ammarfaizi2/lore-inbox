Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269749AbUJAKbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269749AbUJAKbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 06:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269748AbUJAKbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 06:31:18 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:18307 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S269747AbUJAKbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 06:31:15 -0400
Date: Fri, 1 Oct 2004 20:30:32 +1000
From: CaT <cat@zip.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
Message-ID: <20041001103032.GA1049@zip.com.au>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org> <20040930233048.GC7162@zip.com.au> <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 04:56:21PM -0700, Linus Torvalds wrote:
> Now, the reason for using "insert_resource()" in arch/i386/pci/i386.c 
> should go away with Shaohua Li's patch, so I'd love to hear if applying 
> Li's patch _and_ making the "insert_resource()" be a "request_resource()" 
> fixes the problem for you.

You meant this, right?

if (!pr || insert_resource(pr, r) < 0)
	printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));

If so then the patch + the above did not work. :/

> Greg, we kind of left the ACPI resource management breakage pending, and 
> clearly we need some resolution. Comments?

BTW. I just realised (and I apologise for not doing so earlier) that I'm
not using ACPI on this box.

-- 
    Red herrings strewn hither and yon.

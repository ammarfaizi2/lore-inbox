Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268646AbUJTW7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268646AbUJTW7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270343AbUJTWco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:32:44 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:37138 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S270367AbUJTWKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:10:38 -0400
Date: Wed, 20 Oct 2004 23:10:16 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       Hanna Linder <hannal@us.ibm.com>, davej@codemonkey.org.uk,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: [KJ] [RFT 2.6] intel-agp.c: replace pci_find_device with pci_get_device
Message-ID: <20041020221016.GB12553@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, Hanna Linder <hannal@us.ibm.com>,
	davej@codemonkey.org.uk,
	kernel-janitors <kernel-janitors@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
References: <17420000.1098298334@w-hlinder.beaverton.ibm.com> <20041020220347.GZ16153@parcelfarce.linux.theplanet.co.uk> <20041020220638.GA26465@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020220638.GA26465@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 11:06:38PM +0100, Christoph Hellwig wrote:

 > > > As pci_find_device is going away soon I have converted this file to use
 > > > pci_get_device instead. I have compile tested it. If anyone has this hardware
 > > > and could test it that would be great.
 > > 
 > > Should be converted to the pci_driver API.
 > 
 > No.  It's already using the pci_driver API, but the same device can be
 > handled differently depending on the presence of another one.  Maybe
 > pci_dev_present would fit here.

Maybe, but if this kind of cleanup work is done on this code,
I want it sat in -mm for quite a while. This code has been
quite fragile in the past, and I've lost count how many
times we've broken some Intel i8xx variant inadvertantly.

The fragility is a good indicator however to just how crap
that code actually is, and was one of my motivations for
moving the EM64T stuff to the -mch driver.

		Dave


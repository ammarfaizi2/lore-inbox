Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVFCWqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVFCWqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 18:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVFCWqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 18:46:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:3482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261160AbVFCWqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 18:46:06 -0400
Date: Fri, 3 Jun 2005 15:45:51 -0700
From: Greg KH <gregkh@suse.de>
To: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org, roland@topspin.com, davem@davemloft.net
Subject: pci_enable_msi() for everyone?
Message-ID: <20050603224551.GA10014@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In talking with a few people about the MSI kernel code, they asked why
we can't just do the pci_enable_msi() call for every pci device in the
system (at somewhere like pci_enable_device() time or so).  That would
let all drivers and devices get the MSI functionality without changing
their code, and probably make the api a whole lot simpler.

Now I know the e1000 driver would have to specifically disable MSI for
some of their broken versions, and possibly some other drivers might
need this, but the downside seems quite small.

Or am I missing something pretty obvious here?

thanks,

greg k-h

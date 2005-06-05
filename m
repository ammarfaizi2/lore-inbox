Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVFETrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVFETrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFETrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 15:47:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56809
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261283AbVFETrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 15:47:06 -0400
Date: Sun, 05 Jun 2005 12:46:12 -0700 (PDT)
Message-Id: <20050605.124612.63111065.davem@davemloft.net>
To: gregkh@suse.de
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050603224551.GA10014@kroah.com>
References: <20050603224551.GA10014@kroah.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@suse.de>
Date: Fri, 3 Jun 2005 15:45:51 -0700

> Now I know the e1000 driver would have to specifically disable MSI for
> some of their broken versions, and possibly some other drivers might
> need this, but the downside seems quite small.
> 
> Or am I missing something pretty obvious here?

This is totally undesirable.  We don't want the device sending
out MSI messages unless the driver for it explicitly knows
that it is operating the device in this mode.

TG3 will disable MSI for several chip variants as well.  It will
also disable MSI if it's internal self-test of MSI functionality
fails.

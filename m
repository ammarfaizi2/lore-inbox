Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264926AbUGBVCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbUGBVCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUGBVCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:02:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:15748 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264926AbUGBVCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:02:16 -0400
Date: Fri, 2 Jul 2004 13:57:12 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add some PCI Express constants to pci.h
Message-ID: <20040702205712.GE29580@kroah.com>
References: <52r7rwj40o.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52r7rwj40o.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 11:26:47AM -0700, Roland Dreier wrote:
> This patch adds some PCI Express register constants to <linux/pci.h>
> 
> For my device, setting the Max_Read_Request_Size value in the PCI
> Express device control register makes a huge performance difference.
> I wanted my driver code that does this to be a little more
> self-documenting than:
> 
> 	pci_read_config_word(mdev->pdev, cap + 8, &val);
> 	val = (val & ~(5 << 12)) | (5 << 12);
> 
> I went a little overboard and added all the basic device register
> fields.  If desired I could go even further overboard and add the
> link, slot and root registers as well.
> 
> This patch is based on Matthew Wilcox's patch for pciutils, corrected
> for some PCI Express spec 1.0a changes.
> 
> Signed-off-by: Roland Dreier <roland@topspin.com>

Applied, thanks.

greg k-h

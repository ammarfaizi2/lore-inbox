Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVAaTQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVAaTQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVAaTQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:16:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:52702 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261324AbVAaTQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:16:07 -0500
Date: Mon, 31 Jan 2005 11:15:46 -0800
From: Greg KH <greg@kroah.com>
To: Brian King <brking@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: pci: Arch hook to determine config space size
Message-ID: <20050131191546.GA22428@kroah.com>
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <20050128185234.GB21760@infradead.org> <20050129040647.GA6261@kroah.com> <41FE82B6.9060407@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FE82B6.9060407@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 01:10:46PM -0600, Brian King wrote:
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> +

Kernel functions traditionally return 0 for success and -ESOMETHING for
error.  Care to fix this up to match that convention?

thanks,

greg k-h

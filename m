Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWAKR51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWAKR51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWAKR51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:57:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:1930 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932415AbWAKR50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:57:26 -0500
Date: Wed, 11 Jan 2006 07:51:42 -0800
From: Greg KH <greg@kroah.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
Message-ID: <20060111155142.GA19828@kroah.com>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com> <20060103231304.56e3228b.akpm@osdl.org> <1136422680.30655.1.camel@sli10-desk.sh.intel.com> <20060110202841.GZ19769@parisc-linux.org> <1136942240.5750.35.camel@sli10-desk.sh.intel.com> <20060111012625.GA29108@kroah.com> <1136967502.5750.65.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136967502.5750.65.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 04:18:22PM +0800, Shaohua Li wrote:
> +struct pci_cap_saved_state {
> +	struct pci_cap_saved_state *next;
> +	char cap_nr;
> +	u32 data[0];
> +};

Use the in-kernel list functions instead of creating your own logic for
a linked list.

thanks,

greg k-h

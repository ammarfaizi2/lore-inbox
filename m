Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWAKSjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWAKSjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWAKSjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:39:48 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:28574 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751523AbWAKSjs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:39:48 -0500
Date: Wed, 11 Jan 2006 11:39:47 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
Message-ID: <20060111183947.GD19769@parisc-linux.org>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com> <20060103231304.56e3228b.akpm@osdl.org> <1136422680.30655.1.camel@sli10-desk.sh.intel.com> <20060110202841.GZ19769@parisc-linux.org> <1136942240.5750.35.camel@sli10-desk.sh.intel.com> <20060111012625.GA29108@kroah.com> <1136967502.5750.65.camel@sli10-desk.sh.intel.com> <20060111155142.GA19828@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111155142.GA19828@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 07:51:42AM -0800, Greg KH wrote:
> On Wed, Jan 11, 2006 at 04:18:22PM +0800, Shaohua Li wrote:
> > +struct pci_cap_saved_state {
> > +	struct pci_cap_saved_state *next;
> > +	char cap_nr;
> > +	u32 data[0];
> > +};
> 
> Use the in-kernel list functions instead of creating your own logic for
> a linked list.

BTW, please use the hlist functions, not list_head for this case.

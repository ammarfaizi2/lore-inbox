Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTEJP7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264416AbTEJP7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:59:23 -0400
Received: from granite.he.net ([216.218.226.66]:24849 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264414AbTEJP7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:59:20 -0400
Date: Sat, 10 May 2003 09:12:19 -0700
From: Greg KH <greg@kroah.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: Christoph Hellwig <hch@infradead.org>,
       Francois Romieu <romieu@fr.zoreil.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [UPDATE] unbalanced exit path in Forerunner HE he_init_one() (and an iphase patch too!)
Message-ID: <20030510161219.GB5580@kroah.com>
References: <20030510062015.A21408@infradead.org> <200305101352.h4ADqoGi014392@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305101352.h4ADqoGi014392@locutus.cmf.nrl.navy.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 09:52:49AM -0400, chas williams wrote:
> In message <20030510062015.A21408@infradead.org>,Christoph Hellwig writes:
> >> +init_one_failure:
> >> +	if (atm_dev) atm_dev_deregister(atm_dev);
> >> +	if (he_dev) kfree(he_dev);
> >> +	pci_disable_device(pci_dev);
> >> +	return err;
> >
> >kfree(NULL) if perfectly fine.  Also please untangle all this if
> >statements to two separate lines.
> 
> but its ok for usb drivers?

Not at all.  I'll gladly take patches to fix this crud up.

thanks,

greg k-h

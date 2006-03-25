Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWCYCWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWCYCWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 21:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWCYCWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 21:22:37 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:7328 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751616AbWCYCWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 21:22:36 -0500
Date: Fri, 24 Mar 2006 18:22:06 -0800
From: Greg KH <greg@kroah.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, john.ronciak@intel.com,
       jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] PCI Error Recovery: e1000 network device driver
Message-ID: <20060325022206.GA6361@kroah.com>
References: <20060324220002.GC26137@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324220002.GC26137@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 04:00:02PM -0600, Linas Vepstas wrote:
> +	/* Perform card reset only on one instance of the card */
> +	if(0 != PCI_FUNC (pdev->devfn))
> +		return PCI_ERS_RESULT_RECOVERED;

You seem to have forgotton to put a ' ' after the 'if' in a number of
different places in this patch.  Also the (0 != foo) form is a bit
different from the traditional kernel coding style.

> +	switch(adapter->hw.mac_type) {

And here too.

Remember, "if" and "switch" are not functions...

thanks,

greg k-h

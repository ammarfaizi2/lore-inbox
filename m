Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265962AbUGZP7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265962AbUGZP7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 11:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUGZP7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 11:59:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:25794 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265962AbUGZPQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 11:16:28 -0400
Subject: Re: [announce] HVCS for inclusion in 2.6 tree
From: Ryan Arnold <rsa@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20040722192152.7f37ea91.akpm@osdl.org>
References: <1089819720.3385.66.camel@localhost>
	 <16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	 <1090528007.3161.7.camel@localhost> <20040722192152.7f37ea91.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1090846629.3161.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 07:57:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-22 at 21:21, Andrew Morton wrote:
> > +	retval = hvcs_get_partner_info(unit_address, &head, hvcs_pi_buff);
> > +	if (retval) {
> > +		printk(KERN_ERR "HVCS: Failed to fetch partner"
> > +			" info for vty-server@%x.\n",unit_address);
> > +		spin_lock_irqsave(&hvcs_pi_lock, flags);
> 
>                 ^^ spin_unlock
> 
> > +		return retval;
> > +	}
> > +	spin_unlock_irqrestore(&hvcs_pi_lock, flags);
> > 
> 
> (Just move the spin_unlock() to be prior to the test of retval).
> 
> Suggest you review all similar code in the patch for the same copy-n-paste
> bug.

Whoops!  Thanks for catching that.  I'll make sure it doesn't show up elsewhere.

Ryan S. Arnold
IBM Linux Technology Center


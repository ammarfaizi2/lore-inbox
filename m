Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVHRFNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVHRFNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 01:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVHRFNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 01:13:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:23774 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750722AbVHRFNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 01:13:34 -0400
Date: Wed, 17 Aug 2005 22:13:01 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
       linux-kernel@vger.kernel.org, linas@austin.ibm.com,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH]  Add pci_walk_bus function to PCI core (nonrecursive)
Message-ID: <20050818051301.GB29301@kroah.com>
References: <17156.3965.483826.692623@cargo.ozlabs.ibm.com> <1124341108.8849.75.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124341108.8849.75.camel@gaston>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 02:58:28PM +1000, Benjamin Herrenschmidt wrote:
> I wonder if it's finally time to implement proper race free list
> iterators in the kernel. Not that difficult... A small struct iterator
> with a list head and the current elem pointer, and the "interated" list
> containing the list itself, a list of iterators and a lock. Iterators
> can then be "fixed" up on element removal with a fine grained lock on
> list structure access.

Pat tried to do that with klist, but people seem to think it's still
racy in some corner cases.  Have you looked at them?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+w=401wt.eu-S932290AbWLLUgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWLLUgE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWLLUgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:36:04 -0500
Received: from cantor.suse.de ([195.135.220.2]:41337 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932290AbWLLUgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:36:02 -0500
Date: Tue, 12 Dec 2006 12:35:43 -0800
From: Greg KH <gregkh@suse.de>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2]: Renumber PCI error enums to start at zero
Message-ID: <20061212203543.GA4991@suse.de>
References: <20061212195524.GG4329@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212195524.GG4329@austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 01:55:24PM -0600, Linas Vepstas wrote:
> 
> Greg, Andrew,
> 
> This patch fixes an annoying numbering mistake. 
> Please apply this (and the next patch).
> 
> --linas
> 
> Subject: [PATCH 1/2]: Renumber PCI error enums to start at zero
> 
> Renumber the PCI error enums to start at zero for "normal/online".
> This allows un-initialized pci channel state (which defaults to zero)
> to be interpreted as "normal".  Add very simple routine to check
> state, just in case this ever has to be fiddled with again.

No, as you have a specific type for this state, never test it against
"zero".  That just defeats the whole issue of having a special type for
this state.

So you should not have to change the values of the enumerated type for
the code to work properly.  In fact, I would argue that we should not
change it for this very reason :)

So, care to respin these without the enum changes to provide the new
function and use it?

thanks,

greg k-h

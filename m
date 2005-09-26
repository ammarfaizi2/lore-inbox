Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVI0HTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVI0HTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVI0HTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:19:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:31950 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964837AbVI0HTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:19:06 -0400
Date: Mon, 26 Sep 2005 14:35:57 -0700
From: Greg KH <greg@kroah.com>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pci_ids.h: cleanup: whitespace and remove unused entries
Message-ID: <20050926213557.GA21973@kroah.com>
References: <937ti1hpvcjdk8hf894h651s81nu6il239@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937ti1hpvcjdk8hf894h651s81nu6il239@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 09:22:36PM +1000, Grant Coady wrote:
> Greetings,
> 
> This patch cleans up pci_ids.h, reducing size of the file from 
> 104448 to 73438 bytes.  Due to the scripted changes and the 
> requirement to maintain ordering within the file I had to reformat 
> whitespace.
> 
> Compile tested with 'make allmodconfig' with some stuff turned 
> off to get a compile completion.  No missing PCI_* symbols.
> 
> Next step is to fix PCI_* defines distributed in the source, also 
> this file is meant to be included via 'pci.h' some files may need a 
> reference to pci_ids.h removed.  
> 
> As attachment as patch is 92k.

I don't think you need the change to the comments at the top of the
file.

Also, I thought we wanted to keep all of the pci class ids, why did you
delete them?  We should start by removing the pci device and vendor ids
that are not currently used by the kernel, and then slowly move those
ids into the individual drivers, starting with the device ids, and maybe
eventually moving to the vendor ids.

Sound ok?

thanks,

greg k-h

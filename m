Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265899AbTFSTAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbTFSTAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:00:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24010 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265899AbTFSTAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:00:32 -0400
Date: Thu, 19 Jun 2003 12:14:24 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chris@wirex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI device list locking - take 3
Message-ID: <20030619191424.GA5552@kroah.com>
References: <20030619181412.GA5257@kroah.com> <20030619114901.A23053@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030619114901.A23053@figure1.int.wirex.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 11:49:01AM -0700, Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
> > Here's the latest version of the pci list locking patch.  I've taken
> > Chris's comments and addressed them by making sure we don't walk off the
> > end of a deleted device in the pci_find_* and pci_get_* functions.
> 
> Looks good.  Perhaps the pci_proc_detach should be earlier (i.e. before
> list removal) to reflect the order in which things are added.  I'm not
> sure of the dependencies, but seems a good practice anyway.

Thanks, I'll go fix that one just to be safe.

greg k-h

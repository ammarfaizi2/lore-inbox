Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265888AbTFSSgH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbTFSSgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 14:36:07 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:18931 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S265888AbTFSSgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 14:36:05 -0400
Date: Thu, 19 Jun 2003 11:49:01 -0700
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI device list locking - take 3
Message-ID: <20030619114901.A23053@figure1.int.wirex.com>
References: <20030619181412.GA5257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030619181412.GA5257@kroah.com>; from greg@kroah.com on Thu, Jun 19, 2003 at 11:14:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> Here's the latest version of the pci list locking patch.  I've taken
> Chris's comments and addressed them by making sure we don't walk off the
> end of a deleted device in the pci_find_* and pci_get_* functions.

Looks good.  Perhaps the pci_proc_detach should be earlier (i.e. before
list removal) to reflect the order in which things are added.  I'm not
sure of the dependencies, but seems a good practice anyway.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWEZN5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWEZN5V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 09:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWEZN5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 09:57:21 -0400
Received: from vbn.0012335.lodgenet.net ([67.96.213.158]:32682 "EHLO
	vbn.0012335.lodgenet.net") by vger.kernel.org with ESMTP
	id S1750757AbWEZN5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 09:57:20 -0400
Date: Fri, 26 May 2006 06:50:39 -0700
From: Greg KH <greg@kroah.com>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: pci_walk_bus race condition
Message-ID: <20060526135039.GA13280@kroah.com>
References: <1148625315.4377.518.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148625315.4377.518.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 02:35:16PM +0800, Zhang, Yanmin wrote:
> pci_walk_bus has a race with pci_destroy_dev. In the while loop,
> when the callback function is called, dev pointed by next might be
> freed and erased. So later on access to dev might cause kernel panic.

Have you seen this happen?  The only user of this function is the PPC64
EEH handler, which last time I checked, didn't run on Intel based
processors :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752373AbWJODwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbWJODwy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 23:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbWJODwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 23:52:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:15285 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752372AbWJODwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 23:52:54 -0400
Date: Sat, 14 Oct 2006 20:52:06 -0700
From: Greg KH <gregkh@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       R.E.Wolff@BitWizard.nl, Amit Gud <gud@eth.net>
Subject: Re: [PATCH 1/1] Char: correct pci_get_device changes
Message-ID: <20061015035206.GA28623@suse.de>
References: <1966866271061818079@wsc.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1966866271061818079@wsc.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 01:36:45AM +0200, Jiri Slaby wrote:
> correct pci_get_device changes
> 
> Commits 881a8c120acf7ec09c90289e2996b7c70f51e996 and
> efe1ec27837d6639eae82e1f5876910ba6433c3f are totally wrong and
> "Replace pci_find_device() with more safer pci_get_device()." holds only for a
> very short time until next iteration of pci_get_device is called (and
> refcount is decreased again there).
> 
> Whenever pci_find_device -> pci_get_device change is performed, also
> pci_dev_get and pci_dev_put should be in most cases called. If not, it's
> not easy to find such issues and this is example of such case. Here it
> was made safer in no way but a moment during initialization, weird.
> 
> It affects moxa and rio char drivers. (All this stuff deserves to be
> converted to pci_probing, though.)
> 
> Cc: <R.E.Wolff@BitWizard.nl>
> Cc: Amit Gud <gud@eth.net>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>


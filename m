Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVBNLI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVBNLI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 06:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVBNLI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 06:08:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59590 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261398AbVBNLIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 06:08:55 -0500
Date: Mon, 14 Feb 2005 11:08:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Michal Rokos <michal@rokos.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: avoiding pci_disable_device()...
Message-ID: <20050214110854.GA2367@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michal Rokos <michal@rokos.info>, linux-kernel@vger.kernel.org
References: <200502141143.02205.michal@rokos.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502141143.02205.michal@rokos.info>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 11:43:02AM +0100, Michal Rokos wrote:
> Hello,
> 
> > Currently, in almost every PCI driver, if pci_request_regions() fails -- 
> > indicating another driver is using the hardware -- then 
> > pci_disable_device() is called on the error path, disabling a device 
> > that another driver is using
> > 
> > To call this "rather rude" is an understatement :)
> 
> I believe this is needed for natsemi to be inline with $SUBJ.

Why?  I don't think there's any old-style driver for natsemi.  And if
there was please switch it to use modern pci probing or kill it.


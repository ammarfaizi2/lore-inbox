Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbVICFfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbVICFfO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbVICFfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:35:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:49639 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161144AbVICFfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:35:12 -0400
Date: Fri, 2 Sep 2005 22:31:11 -0700
From: Greg KH <greg@kroah.com>
To: iSteve <isteve@rulez.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SysFS, module names and .name
Message-ID: <20050903053111.GB23711@kroah.com>
References: <43176488.2080608@rulez.cz> <20050902155338.GA13648@kroah.com> <4318CF95.5040801@rulez.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4318CF95.5040801@rulez.cz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 12:17:57AM +0200, iSteve wrote:
> Yes, I am rather interested -- could you please provide details about 
> this method?

For PCI drivers, just add the line:
	.owner = THIS_MODULE,

to their struct pci_driver definition and you will get the symlink
created for you.

USB drivers already do this.

Hope this helps,

greg k-h

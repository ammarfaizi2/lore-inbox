Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267134AbTGKX5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 19:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbTGKX5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 19:57:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:49555 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267134AbTGKX5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 19:57:43 -0400
Date: Fri, 11 Jul 2003 17:08:58 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sound updating, security of strlcpy and a question on pci v unload
Message-ID: <20030712000858.GA23659@kroah.com>
References: <1057943137.20637.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057943137.20637.27.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 06:05:37PM +0100, Alan Cox wrote:
> 
> Secondly a question. pci_driver structures seem to lack an owner: field.
> What stops a 2.5 module unload occuring while pci is calling the probe
> function having seen a new device ? 

The pci subsystem rw semaphore.

thanks,

greg k-h

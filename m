Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTLLV0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLLV0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:26:03 -0500
Received: from mail.kroah.org ([65.200.24.183]:39563 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261956AbTLLV0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:26:01 -0500
Date: Fri, 12 Dec 2003 13:16:13 -0800
From: Greg KH <greg@kroah.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP over ttyUSB (visor.o, Treo)
Message-ID: <20031212211613.GD2002@kroah.com>
References: <20031210165540.B26394@fi.muni.cz> <20031210212807.GA8784@kroah.com> <20031211142508.X26728@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211142508.X26728@fi.muni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 02:25:08PM +0100, Jan Kasprzak wrote:
> Greg KH wrote:
> : 
> : Can you try the patch below?  I think it will fix the problem.
> : 
> 	Well, it fixes the problem (pppd connects, and works OK),
> but the kernel complains about badness in local_bh_enable.
> 
> 	Full syslog is at http://www.fi.muni.cz/~kas/tmp/visor-mesages.txt,
> kernel config is at http://www.fi.muni.cz/~kas/tmp/visor-kconfig.txt.
> Any other info I should add?

Nah, this is a known problem, sorry.  The usb-serial core needs to have
the same kind of patch that the cdc-acm driver just had (change to use a
tasklet).  It's on my TODO list...

thanks,

greg k-h

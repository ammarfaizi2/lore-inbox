Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVI0OuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVI0OuA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVI0OuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:50:00 -0400
Received: from [85.21.88.2] ([85.21.88.2]:62340 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S964952AbVI0Ot7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:49:59 -0400
Subject: Re: [spi-devel-general] Re: SPI
From: dmitry pervushin <dpervushin@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
In-Reply-To: <20050927143505.GA24245@kroah.com>
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
	 <20050927124335.GA10361@kroah.com>
	 <1127831236.7577.33.camel@diimka.dev.rtsoft.ru>
	 <20050927143505.GA24245@kroah.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 18:49:57 +0400
Message-Id: <1127832597.7577.37.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 07:35 -0700, Greg KH wrote:
> Please read up on how the lifetime rules work for devices, and what
> needs to happen in the release function (hint, take a look at other
> busses, like USB and PCI for examples of what needs to be done.)
As far as I can see, pci_release_device deletes the pci_dev using kfree.
But here we have statically allocated spi_device structures --
spi_device_add does not allocate spi_device, but uses caller-allocated
one.
> 
> thanks,
> 
> greg k-h
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. Download
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> 
> 


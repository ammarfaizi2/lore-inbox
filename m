Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVI0Oft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVI0Oft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVI0Oft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:35:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:58793 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964948AbVI0Ofs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:35:48 -0400
Date: Tue, 27 Sep 2005 07:35:06 -0700
From: Greg KH <greg@kroah.com>
To: dmitry pervushin <dpervushin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] Re: SPI
Message-ID: <20050927143505.GA24245@kroah.com>
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru> <20050927124335.GA10361@kroah.com> <1127831236.7577.33.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127831236.7577.33.camel@diimka.dev.rtsoft.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 06:27:16PM +0400, dmitry pervushin wrote:
> On Tue, 2005-09-27 at 05:43 -0700, Greg KH wrote:
> > This is ALWAYS wrong, please fix your code.  See the many times I have
> > been over this issue in the archives.
> Do you mean this comment ? The spi_device_release does nothing, just to
> prevent compains from device_release function :)

Think about why the kernel complains about a non-existant release
function.  Just replacing that complaint with a function that does
nothing does NOT solve the issue, it only makes the warning go away.

Please read up on how the lifetime rules work for devices, and what
needs to happen in the release function (hint, take a look at other
busses, like USB and PCI for examples of what needs to be done.)

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVAXLwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVAXLwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 06:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVAXLwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 06:52:51 -0500
Received: from canuck.infradead.org ([205.233.218.70]:14853 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261502AbVAXLwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 06:52:49 -0500
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on USB_STORAGE=n
From: David Woodhouse <dwmw2@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, mdharm-usb@one-eyed-alien.net,
       zaitcev@yahoo.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050119220707.GM4151@kroah.com>
References: <20041220001644.GI21288@stusta.de>
	 <20041220003146.GB11358@kroah.com> <20041223024031.GO5217@stusta.de>
	 <20050119220707.GM4151@kroah.com>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 11:48:51 +0000
Message-Id: <1106567331.6480.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 14:07 -0800, Greg KH wrote:
> I have been running with just the code portion of this patch for a while
> now, with good results (no Kconfig changes.)
> 
> Pete and Matt, do you mind me applying the following portion of the
> patch to the kernel tree?
> 
> > -#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
> >  UNUSUAL_DEV(  0x0781, 0x0002, 0x0009, 0x0009, 
> >  		"Sandisk",
> >  		"ImageMate SDDR-31",
> >  		US_SC_DEVICE, US_PR_DEVICE, NULL,
> >  		US_FL_IGNORE_SER ),
> > -#endif

Urgh. Please do. Code which may compile differently in the kernel image
according to which _modules_ are configured at the time is horrid, and
should be avoided.

-- 
dwmw2


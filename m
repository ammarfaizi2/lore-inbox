Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbTJIPQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTJIPQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:16:29 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:40592 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262260AbTJIPQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:16:28 -0400
Subject: Re: Call trace when rmmod'ing saa7134 and error when compiling
	static
From: Stian Jordet <liste@jordet.nu>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031009151534.GA20553@bytesex.org>
References: <1065708534.737.2.camel@chevrolet.hybel>
	 <20031009151534.GA20553@bytesex.org>
Content-Type: text/plain
Message-Id: <1065712607.676.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 17:16:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 09.10.2003 kl. 17.15 skrev Gerd Knorr:
> On Thu, Oct 09, 2003 at 04:08:54PM +0200, Stian Jordet wrote:
> > Hello,
> > 
> > when I try to rmmod the saa7134 module from kernel 2.6.0-test7, I get
> > this call trace:
> > 
> > Device class 'i2c-1' does not have a release() function, it is broken
> > and must be fixed.
> > Badness in class_dev_release at drivers/base/class.c:200
> > Call Trace:
> >  [<c02be4d5>] kobject_cleanup+0x85/0x90
> >  [<c03e0040>] i2cdev_detach_adapter+0x0/0x40
> >  [<c03e0069>] i2cdev_detach_adapter+0x29/0x40
> >  [<c03dd216>] i2c_del_adapter+0x1c6/0x200
> >  [<e8a7bb59>] .text.lock.saa7134_tvaudio+0x37/0x3e [saa7134]
> >  [<e8a77784>] saa7134_i2c_unregister+0x14/0x20 [saa7134]
> 
> Hmm, funny, doesn't happen here ...
> 
> Also not sure whenever this is a bug in the i2c core or in the saa7134
> driver ...

Hmm. Weird. 100% reproducable here. Anything I can do to help finding
out what causes it? The same happens with the patch from your page.

Best regards,
Stian


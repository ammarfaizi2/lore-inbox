Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTJIPFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTJIPFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:05:17 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:34708 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262259AbTJIPFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:05:08 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 9 Oct 2003 17:15:34 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call trace when rmmod'ing saa7134 and error when compiling static
Message-ID: <20031009151534.GA20553@bytesex.org>
References: <1065708534.737.2.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065708534.737.2.camel@chevrolet.hybel>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 04:08:54PM +0200, Stian Jordet wrote:
> Hello,
> 
> when I try to rmmod the saa7134 module from kernel 2.6.0-test7, I get
> this call trace:
> 
> Device class 'i2c-1' does not have a release() function, it is broken
> and must be fixed.
> Badness in class_dev_release at drivers/base/class.c:200
> Call Trace:
>  [<c02be4d5>] kobject_cleanup+0x85/0x90
>  [<c03e0040>] i2cdev_detach_adapter+0x0/0x40
>  [<c03e0069>] i2cdev_detach_adapter+0x29/0x40
>  [<c03dd216>] i2c_del_adapter+0x1c6/0x200
>  [<e8a7bb59>] .text.lock.saa7134_tvaudio+0x37/0x3e [saa7134]
>  [<e8a77784>] saa7134_i2c_unregister+0x14/0x20 [saa7134]

Hmm, funny, doesn't happen here ...

Also not sure whenever this is a bug in the i2c core or in the saa7134
driver ...

  Gerd


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267414AbUIJONT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267414AbUIJONT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbUIJONT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:13:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:26061 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267414AbUIJONS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:13:18 -0400
Date: Fri, 10 Sep 2004 07:01:53 -0700
From: Greg KH <greg@kroah.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Re: 2.6.9-rc1-mm4, visor.c, Badness in usb_unlink_urb
Message-ID: <20040910140152.GA15589@kroah.com>
References: <20040910082601.GA32746@gamma.logic.tuwien.ac.at> <200409101148.37587.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409101148.37587.petkov@uni-muenster.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 11:48:37AM +0200, Borislav Petkov wrote:
> remove the deprecated call to usb_unlink_urb.
> 
> Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> 
> --- linux-2.6.9-rc1-mm/drivers/usb/serial/visor.c.orig 2004-09-10 
> 11:35:11.000000000 +0200

Ick, your patch was line wrapped, and all of the tabs stripped out of it
:(

Anyway, I converted all of the files in drivers/usb/serial/* that needed
it to usb_kill_urb() yesterday, and checked them into my bk-usb tree and
will show up in the next -mm release.

But if you want to tackle the other drivers in the tree, please do so :)

thanks,

greg k-h

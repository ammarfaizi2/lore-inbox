Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264119AbUFKQds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUFKQds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUFKQ0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:26:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:45792 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264147AbUFKQTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:19:21 -0400
Date: Fri, 11 Jun 2004 09:17:48 -0700
From: Greg KH <greg@kroah.com>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: linux-usb-devel@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, rtjohnso@eecs.berkeley.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040611161747.GA2167@kroah.com>
References: <E1BYXuJ-0006vd-RU@sc8-sf-list1.sourceforge.net> <20040611063107.0c62e2f8.luca.risolia@studio.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040611063107.0c62e2f8.luca.risolia@studio.unibo.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 06:31:07AM +0200, Luca Risolia wrote:
> >                    unsigned int cmd, void* arg)
> >  {
> >  	struct w9968cf_device* cam;
> > +	void __user *user_arg = (void __user *)arg;
> 
> The right place to apply this patch is in video_usercopy().

Um, the driver you just refered to does not use the video_usercopy()
function so your email doesn't make much sense in this context.

> Please have a look at definition of the function in videodev.c.

Please excuse me while I go get sick...

Anyway, that function needs to be properly marked up with __user if you
want it to live.

good luck,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUFJSz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUFJSz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUFJSz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:55:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:11695 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262389AbUFJSz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:55:57 -0400
Date: Thu, 10 Jun 2004 11:54:51 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-usb-devel@lists.sourceforge.net,
       "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610185451.GA1490@kroah.com>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com> <20040610183442.GA1271@kroah.com> <20040610184520.GI12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610184520.GI12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 07:45:20PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Jun 10, 2004 at 11:34:42AM -0700, Greg KH wrote:
> >  	struct usb_mixerdev *ms = (struct usb_mixerdev *)file->private_data;
> >  	int i, j, val;
> > +	int __user *int_user_arg = (int __user *)arg;
> 
> Egads...  How about changing the name to something that would not be so
> scary?

Ick, sorry about that.  Years of writing windows code sometimes pops up
from my subconsious and tries to name things in hungarian notation
style.

I'll go fix up all int_user_arg names that I just added...

thanks,

greg k-h

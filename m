Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266092AbUFIWrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266092AbUFIWrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUFIWrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:47:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:5264 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266092AbUFIWrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:47:07 -0400
Date: Wed, 9 Jun 2004 15:45:49 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Couple of sysfs patches
Message-ID: <20040609224548.GA1393@kroah.com>
References: <200406090221.24739.dtor_core@ameritech.net> <20040609221337.GG16653@kroah.com> <200406091732.28684.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406091732.28684.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 05:32:28PM -0500, Dmitry Torokhov wrote:
> Actually, I myself want someting else -
> 
> int platform_device_register_simple(struct platform_device **ppdev,
> 				    const char *name, int id)
> 
> It will allocate platform device, set name and id and release function to
> platform_device_simple_release which in turn will be hidden from outside
> world. Since the function does allocation for user is should prevent the
> abuse you were concerned about.

Ok, that sounds good.  I'll take patches for that kind of interface.

But have the function return the pointer, like the class_simple
functions work.  Not the ** like you just specified.

> > Unless you show me a real need for it..
> > 
> > And as for the whitespace cleanup, why?  The lack of spaces seem to be
> > something that the original author liked doing.  There's nothing in the
> > kernel coding style guidelines that really mention it that I can see.
> >
>  
> If you check the files in question there were already both styles present
> (with and without spaces). And trailing whitespace looks bloody red in my
> vi ;) Will you accept just trailing whitespace cleanup?

Hm, ok, you are correct about the duplicate styles, ok, I'll take the
whole cleanup.  But things have changed in these files lately, and your
patch doesn't apply :(  Care to resend this against the latest -mm
release which has all of the changes in it?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbVJRHk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVJRHk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbVJRHk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:40:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:50878 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751457AbVJRHk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:40:57 -0400
Date: Tue, 18 Oct 2005 00:38:09 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, Brice Goglin <Brice.Goglin@ens-lyon.org>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.14-rc4-mm1
Message-ID: <20051018073809.GA12406@kroah.com>
References: <20051016154108.25735ee3.akpm@osdl.org> <200510180209.49080.dtor_core@ameritech.net> <20051018071712.GA12145@kroah.com> <200510180222.41966.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510180222.41966.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 02:22:41AM -0500, Dmitry Torokhov wrote:
> On Tuesday 18 October 2005 02:17, Greg KH wrote:
> > 
> > Because before my patch, any class_device created for the input class,
> > had the name, phys, and uniq attributes created for them, including the
> > "simple" class device structures event0, event1, and so on.  The kobject
> > being passed back to those callback functions was not of the same type
> > of object as input0, input1 and so on.  So bad things happened.
> 
> Oh, I see. That's what you get for mixing devices of different classes
> into one class ;)

I agree, it's tough, nasty, and full of horrible issues like this.  I
got away with much the same mess with the USB core code where we mix
devices of different types on the same bus, but I wouldn't recommend
ever doing that again.

So, when we move everything over to being only devices, I'll try to make
problems like this impossible to occur, as it's a pain...

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUKPTUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUKPTUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbUKPTTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:19:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:28626 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262097AbUKPTRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:17:18 -0500
Date: Tue, 16 Nov 2004 11:16:43 -0800
From: Greg KH <greg@kroah.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041116191643.GA10021@kroah.com>
References: <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com> <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu> <20041116175857.GA9213@kroah.com> <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 08:09:10PM +0100, Miklos Szeredi wrote:
> 
> > > So if I only need a single device number should I register a "misc"
> > > device?  misc_register() seems to create the relevant sysfs entry.
> > 
> > Yes, that is a good way to get a device, without having to reserve a
> > number.
> 
> No, I think reserving a number is still necessary: there seems to be
> only a very small space for dynamically registered misc devices (max
> 15), so that's not any better than reserving a static one.

So reserve a minor number of the misc class.  Ask LANNANA for a number
and you should be fine.

> So what I'm interested in, is if I get a reserved minor number for the
> misc (major=10) device, will I be kicked in the butt (by Linus or
> anybody else) like for the /proc approach?

Depends on what your /dev node is trying to do.  What is is doing
anyway?  Any ioctls?  Any wierd, non-chardev like things?

Again, inline code would have been nice to see so those of us who live
in our email clients could have reviewed it...

thanks,

greg k-h

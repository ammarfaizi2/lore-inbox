Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUFKQmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUFKQmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUFKQlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:41:21 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:11935 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S264196AbUFKQjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:39:41 -0400
Date: Fri, 11 Jun 2004 18:46:00 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, rtjohnso@eecs.berkeley.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: Finding user/kernel pointer bugs [no
 html]
Message-Id: <20040611184600.64c9139c.luca.risolia@studio.unibo.it>
In-Reply-To: <20040611161747.GA2167@kroah.com>
References: <E1BYXuJ-0006vd-RU@sc8-sf-list1.sourceforge.net>
	<20040611063107.0c62e2f8.luca.risolia@studio.unibo.it>
	<20040611161747.GA2167@kroah.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 11 Jun 2004 09:17:48 -0700
Greg KH <greg@kroah.com> wrote:

> On Fri, Jun 11, 2004 at 06:31:07AM +0200, Luca Risolia wrote:
> > >                    unsigned int cmd, void* arg)
> > >  {
> > >  	struct w9968cf_device* cam;
> > > +	void __user *user_arg = (void __user *)arg;
> > 
> > The right place to apply this patch is in video_usercopy().
> 
> Um, the driver you just refered to does not use the video_usercopy()
> function so your email doesn't make much sense in this context.

Oops, sorry. I forgot the w9968cf doesn't actually use video_usercopy().
However, apart from the "__user" context, there are several drivers
under drivers/usb/media/ that still use that usercopy() thing.

> 
> > Please have a look at definition of the function in videodev.c.
> 
> Please excuse me while I go get sick...
> 
> Anyway, that function needs to be properly marked up with __user if you
> want it to live.
> 
> good luck,
> 
> greg k-h
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAyeHImdpdKvzmNaQRAgSbAJ9J+Zq4PsS59Z0muH1nJM036CCBzACglYQO
5/kAGoFHru+NpJ0/wNd0YT0=
=57yE
-----END PGP SIGNATURE-----

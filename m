Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWHaRBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWHaRBy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWHaRBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:01:53 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:5842 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932385AbWHaRBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:01:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fedora vs. swsusp (was Re: megaraid_sas suspend ok, resume oops)
Date: Thu, 31 Aug 2006 19:05:30 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Jens Axboe <axboe@kernel.dk>,
       Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com> <b6a2187b0608290522vea22930y54ac39bfce3127f2@mail.gmail.com> <20060829203951.GA5065@ucw.cz>
In-Reply-To: <20060829203951.GA5065@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311905.30462.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 22:39, Pavel Machek wrote:
> Hi!
> 
> > Another point ... on IBM x60s notebook, setting ...
> > 
> >       High Memory Support (64GB)
> >               CONFIG_HIGHMEM64G=y
> >               CONFIG_RESOURCES_64BIT=y
> >               CONFIG_X86_PAE=y
> 
> > 
> > will cause resume to "REBOOT" sometimes (may be 6 out of 
> > 10).
> 
> Okay, I guess that explains 'swsusp br0ken on Fedora' reports I was
> seening.
> 
> I wonder if swsusp *ever* worked reliably with highmem64...
> 
> ...wait a moment, higmem64 implies PAE implies we can no longer use
> swsusp's trick with copying initial pgdir, and we'll need to use
> x86-64-like code, no?

I think so.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

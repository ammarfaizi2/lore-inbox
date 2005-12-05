Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVLEVrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVLEVrU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVLEVrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:47:19 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:65268 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964809AbVLEVrT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:47:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NFL/PC6o9PyslZZYKz9jPVHEKLwCXm7OZ/tOcjUnL83nB5oamVIYKitXFINhh8ftAQg/QdAWfn1FsbYUOy5WhZkZJIDiN+Zmhi79VHlOsLr5J8fHqy99mjjpwCkRQkIQKPJ7OCt3Lvz4MhicWEsRN5s3m/4AEwvr6MjDDDdhPuQ=
Message-ID: <d120d5000512051347u1d77aabam2b70ef91d8709f39@mail.gmail.com>
Date: Mon, 5 Dec 2005 16:47:18 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Two module-init-
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       Scott James Remnant <scott@ubuntu.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, vojtech@suse.cz
In-Reply-To: <1133691865.30188.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133359773.2779.13.camel@localhost.localdomain>
	 <1133482376.4094.11.camel@localhost.localdomain>
	 <200512022319.05246.dtor_core@ameritech.net>
	 <200512022328.29182.dtor_core@ameritech.net>
	 <1133691865.30188.24.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/05, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Fri, 2005-12-02 at 23:28 -0500, Dmitry Torokhov wrote:
> > On Friday 02 December 2005 23:19, Dmitry Torokhov wrote:
> > > On Thursday 01 December 2005 19:12, Rusty Russell wrote:
> > > > Meanwhile, as noone seems to use swbit in struct input_device_id,
> > > > perhaps we can remove it for 2.6.15?
> > > >
> > >
> > > Please take a look at drivers/input/keyboard/corgikbd.c
> > >
> >
> > What I meant we do use EV_SW in the drivers and so it sould be part
> > of input_device_id. Nobody uses ffbit or sndbit either and still
> > they are present...
>
> Sure.  BUT it will break current users.  I'm suggesting we jerk that
> field out for 2.6.15, and reintroduce it for >= 2.6.16, when we can (1)
> ensure everyone has a fixed module-init tools, or (2) make sure everyone
> is using the module alias stuff, or both.
>
> It seems the simplest solution, surely?

Is there real users that are broken? It looks like most distros either
have mousedev and evdev compiled in or load them unconditionally. So
the simpliest is just probably get MODALIAS stuff in 2.6.16 and that's
it. It's not like swbit is new in 2.6.15, it was there since 2.6.14
was opened.

--
Dmitry

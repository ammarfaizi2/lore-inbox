Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbRGPTvc>; Mon, 16 Jul 2001 15:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265337AbRGPTvV>; Mon, 16 Jul 2001 15:51:21 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:54027 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S265326AbRGPTvU>; Mon, 16 Jul 2001 15:51:20 -0400
Message-ID: <3B534555.345015EC@damncats.org>
Date: Mon, 16 Jul 2001 15:49:41 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Hartmann <jhartmann@valinux.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <E15M6jC-0005PK-00@the-village.bc.nu> <3B532BB7.1050300@valinux.com> <3B533578.A4B6C25F@damncats.org> <3B53413A.6060501@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Hartmann wrote:
> > Would it not be a bit more robust to have a wrapper module that pulls in
> > the correct one on demand? In other words, for the radeon, you would
> > still have the radeon.o module, but it would determine which child
> > module to load depending on the version of X that is requesting it. Thus
> > XFree86 would not require any changes and the backwards compatibility
> > would be maintained invisibly.
> >
> > John
> >
> No, because the 2D ddx module is the one doing all the versioning.  It
> doesn't tell the kernel its version number etc., but the ddx module gets
> the version from the kernel, and fails if its the wrong one.  If the
> kernel was the one doing the checking, then your suggestiong would be a
> nice way of handling it.

Okay, that makes sense. However, this can still work with minimal change
to the 2D module if the next revision passes in the version information
to the kernel module. It doesn't solve the 4.0 to 4.1 transition, but it
still puts the module on a (better?) track. For the 4.0/4.1 modules,
that would have to be a compile time decision or option in the
/etc/modules.conf (options radeon version=x.y.z). Actually, having an
override in the modules.conf would be pretty handy in general.

Also, if you don't want to make changes to the 2D code, the modules.conf
scenario still makes it feasible all around.

John

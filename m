Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264223AbUFGVxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUFGVxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbUFGVxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:53:09 -0400
Received: from gate.firmix.at ([80.109.18.208]:63718 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S265090AbUFGVwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:52:55 -0400
Subject: Re: how to configure/build a kernel in a separate directory?
From: Bernd Petrovitsch <bernd@firmix.at>
To: root@chaos.analogic.com
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0406071710540.1435@chaos>
References: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
	 <Pine.LNX.4.53.0406071710540.1435@chaos>
Content-Type: text/plain
Organization: http://www.firmix.at/
Message-Id: <1086645148.8887.6.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 07 Jun 2004 23:52:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 23:31, Richard B. Johnson wrote:
> On Mon, 7 Jun 2004, Robert P. J. Day wrote:
[...]
> >   (i originally posted this to the "make" mailing list, but i figured
> > someone here *must* have done this before.)

Not only here. And yes.

> >   is there an easy way to configure/build one or both of a 2.4 and 2.6
> > kernel in a totally separate directory from the source directory itself?
> >
> >   i'd like to have a totally pristine ("make mrproper"ed) source tree,
> > write-protected, readable by all, so that several developers can
> > independently configure and build their own kernels without stepping on
> > each other.  currently, they all check out their own copy of the source
> > via CVS, which starts to take up a lot of space.
> >
> >   obviously, it would be great if they could all set up some kind of build
> > structure where they could do their own configuration and build in their
> > personal work directories, so that *all* generated results (header files,
> > object files, etc.) are placed in their work directory -- nothing should
> > be generated in the kernel source tree itself.
> >
> >   i'm suspecting that, if there are solutions, they will be different from
> > 2.4 to 2.6, so i'll take whatever solutions i can get.  others have
> > suggested using gnu make in combination with "VPATH", but i'm not sure
> > that's going to work, as VPATH deals strictly with pre-requisites in other
> > directories, not executable programs like scripts.

VPATH works for make, but not for other scripts and tools.

> I would make a script that creates a symbolic-link of all the
> source-files and headers. To get it right, put the source on
> a r/o file-system as a start. It's a lot of work.

No, lndir exists (somewhere in X11 or XFree86 IIRC).
Just make a sym-linked copy of the (read-only) pristine source
directory.
Voila. And quite easy.

> `find . -name "*.[chS]"` should get all the sources, but there
> are some scripts you will have to hunt for.

No, just take all files which are there. It is simple and works.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



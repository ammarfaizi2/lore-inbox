Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261804AbSIXUzk>; Tue, 24 Sep 2002 16:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbSIXUzk>; Tue, 24 Sep 2002 16:55:40 -0400
Received: from nameservices.net ([208.234.25.16]:11177 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S261804AbSIXUzi>;
	Tue, 24 Sep 2002 16:55:38 -0400
Message-ID: <3D90D388.746D0C0D@opersys.com>
Date: Tue, 24 Sep 2002 17:05:12 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Adeos <adeos-main@mail.freesoftware.fsf.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
References: <3D8E8371.D2070D87@opersys.com> <20020922045907.C35@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Pavel,

Pavel Machek wrote:
> > This is a patch for adding the Adeos nanokernel to the Linux kernel as
> > described earlier:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=102309348817485&w=2
> 
> Maybe adding Docs/adeos.txt is good idea... (sorry can't access web
> right now) --

Right, we'll do that.

> so this is aimed at being free rtlinux replacement?

I'm not sure "replacement" is the appropriate description for this.
The scheme used by rtlinux and rtai is a master-slave scheme where
Linux is a slave to the rt executive. Adeos makes the entire scheme
obsolete by making all the OSes running on the same hardware clients
of the same nanokernel, regardless of whether the client OSes provide
hard RT or not. None of these OSes need to have a "other OS" task,
as rtlinux and rtai clearly do. Rather, when an OS is done using
the machine, it tells Adeos that it's done and Adeos returns control
to whichever other OS is next in the interrupt pipeline.

To be honest, nothing in Adeos is "new". Adeos is implemented on
classic early '90s nanokernel research. I've listed a number of
nanokernel papers in the paper I wrote on Adeos. A complete list
of nanokernel papers would probably have hundreds of entries.
Some of these nanokernels even had OS schedulers (exokernel for
instance). All Adeos implements is a scheme for sharing the
interrupts among the various OSes using an interrupt pipeline.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================

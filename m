Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbQLMVme>; Wed, 13 Dec 2000 16:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131956AbQLMVmY>; Wed, 13 Dec 2000 16:42:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:14608 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129874AbQLMVmN>;
	Wed, 13 Dec 2000 16:42:13 -0500
Message-ID: <3A37E604.41D8BE77@mandrakesoft.com>
Date: Wed, 13 Dec 2000 16:11:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Christian Ullrich <chris@chrullrich.de>, linux-kernel@vger.kernel.org
Subject: Re: insmod problem after modutils upgrading
In-Reply-To: <E146JAu-0003HX-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > how can i make insmod load the network module again pls?
> >
> > I "fixed" the same problem in 2.2.18 by commenting out the line
> >
> > MODULE_PARM (debug, "i");
> >
> > near the end of drivers/net/8139too.c. Since I run modutils 2.3.22
> > as well, it can't be related to the modutils.
> 
> It is modutils. Their behaviour changed in a non back compatible way. Do not
> use modutils 2.3.22 with Linux 2.2.* is the simple answer. Perhaps Keith can
> make this a warning in 2.3.23

That, and/or allow "insmod -f" to load the module.  '-f' has become
pretty useless lately... :)

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

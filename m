Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbTAOSm7>; Wed, 15 Jan 2003 13:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbTAOSm6>; Wed, 15 Jan 2003 13:42:58 -0500
Received: from fmr02.intel.com ([192.55.52.25]:13025 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266865AbTAOSm5>; Wed, 15 Jan 2003 13:42:57 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CACA88@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'DervishD'" <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: argv0 revisited...
Date: Wed, 15 Jan 2003 10:51:40 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > welcome. Although I would like a portable solution, any 
> solution that
> > > works under *any* Linux kernel is welcome...
> > What about mounting /proc from inside your program? Not a 
> big deal, easy
> > sollution ... 
> 
>     I don't like it, because it should happen at the very beginning
> of init. Remember, is not any program, is an init. Should be a more
> clean way, I suppose :??

I don't think is that big a deal ... if you startup the system normally,
sooner or later, /proc is going to be mounted. A [quickie] variation is:

mount()
get the info from /proc/self/whatever
umount()

Is simple, is clean and has no side effects; the code is pretty small, btw

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]



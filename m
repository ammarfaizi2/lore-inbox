Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292893AbSBVPRt>; Fri, 22 Feb 2002 10:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292895AbSBVPR3>; Fri, 22 Feb 2002 10:17:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23306 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292893AbSBVPRW>;
	Fri, 22 Feb 2002 10:17:22 -0500
Message-ID: <3C7660F5.FC238A7E@mandrakesoft.com>
Date: Fri, 22 Feb 2002 10:17:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@sunsite.dk>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, Troy Benjegerdes <hozer@drgw.net>,
        wli@holomorphy.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk> <20020207234555.N17426@altus.drgw.net> <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk> <d37kp5v9y5.fsf@lxplus050.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> 
> Anton Altaparmakov <aia21@cam.ac.uk> writes:
> 
> > At 17:57 08/02/02, Troy Benjegerdes wrote:
> > >Well, there's a reason I left out CONFIG_M68K deps.. Go tell me where
> > >CONFIG_M68K is defined.. ;)
> >
> > Appologies, it's in Configure.help but that is not a too useful places to
> > have it. However the kernel seems to be using:
> >
> > #if defined(__mc68000__) so just use that instead. Any m68k people reading
> > this care to comment?
> 
> __mc68000__ is the correct define, I don't know who put in CONFIG_M68K
> but it doesn't belong there.

I disagree -- look at arch/*/config.in.

Each arch needs to define a CONFIG_$ARCH.

It looks like cris and mk68 are one of the few arches that fail to do
this...
> # Identify this as a Sparc64 build
> define_bool CONFIG_SPARC64 y

Sigh, this should be in an 'arch' specification :)

	Jeff


-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |

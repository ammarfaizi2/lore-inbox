Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292891AbSBVP0j>; Fri, 22 Feb 2002 10:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292901AbSBVP03>; Fri, 22 Feb 2002 10:26:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61707 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292891AbSBVP0X>;
	Fri, 22 Feb 2002 10:26:23 -0500
Message-ID: <3C76631C.E685815D@mandrakesoft.com>
Date: Fri, 22 Feb 2002 10:26:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, Troy Benjegerdes <hozer@drgw.net>,
        wli@holomorphy.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>
		<20020207234555.N17426@altus.drgw.net>
		<5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>
		<d37kp5v9y5.fsf@lxplus050.cern.ch>
		<3C7660F5.FC238A7E@mandrakesoft.com> <15478.25001.512565.628500@trained-monkey.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> 
> >>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> 
> Jeff> Jes Sorensen wrote:
> >> __mc68000__ is the correct define, I don't know who put in
> >> CONFIG_M68K but it doesn't belong there.
> 
> Jeff> I disagree -- look at arch/*/config.in.
> 
> Jeff> Each arch needs to define a CONFIG_$ARCH.
> 
> Why? CONFIG_$ARCH only makes sense if you can enable two architectures
> in the same build. What does CONFIG_M68K give you that __mc68000__
> doesn't provide?

1) it is a Linux kernel standard.  all arches save two define
CONFIG_$arch.

2) you have two tests, "ARCH==m68k" in config.in and "__mc68000__" in C
code.  CONFIG_M68K means you only test one symbol, the same symbol, in
all code.

3) as this thread shows, due to #1, users -expect- that CONFIG_M68K will
exist

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |

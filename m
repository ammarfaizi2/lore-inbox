Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289331AbSAIKva>; Wed, 9 Jan 2002 05:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289328AbSAIKvW>; Wed, 9 Jan 2002 05:51:22 -0500
Received: from [194.206.157.151] ([194.206.157.151]:14022 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S289327AbSAIKvH>; Wed, 9 Jan 2002 05:51:07 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E410@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'dewar@gnat.com'" <dewar@gnat.com>, bernd@gams.at, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org
Subject: RE: [PATCH] C undefined behavior fix
Date: Wed, 9 Jan 2002 11:41:31 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: dewar@gnat.com [mailto:dewar@gnat.com]
> Sent: Wednesday, January 09, 2002 11:42 AM
> To: bernd@gams.at; gcc@gcc.gnu.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] C undefined behavior fix
> 
> 
> <<Especially if there are cases were this optimization yields 
> a slower =
> 
> access (or even worse indirect bugs).
> E.g. if the referenced "volatile short" is a hardware register and the
> access is multiplexed over a slow 8 bit bus.  There are 
> embedded systems
> around where this is the case and the (cross-)compiler has no way to
> know this (except it can be told by the programmer).
> >>
> 
> Well that of course is a situation where the compiler is 
> being deliberately
> misinformed as to the relative costs of various machine 
> instructions, and
> that is definitely a problem. One can even imagine hardware 
> (not such a hard
> feat, one of our customers had such hardware) where a word 
> access works, but
> a byte access fails due to hardware shortcuts, 

Tht's quite often the case with MMIO, and the only portable way to give a
hint to the compiler that it should refrain from optimizing is "volatile";
that's why I think the compiler should not do this optimization on volatile
objects at all.

	Bernard

--------------------------------------------
Bernard Dautrevaux
Microprocess Ingenierie
97 bis, rue de Colombes
92400 COURBEVOIE
FRANCE
Tel:	+33 (0) 1 47 68 80 80
Fax:	+33 (0) 1 47 88 97 85
e-mail:	dautrevaux@microprocess.com
		b.dautrevaux@usa.net
-------------------------------------------- 

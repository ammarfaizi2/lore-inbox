Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262791AbREVU3R>; Tue, 22 May 2001 16:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262798AbREVU3H>; Tue, 22 May 2001 16:29:07 -0400
Received: from mnh-1-24.mv.com ([207.22.10.56]:37896 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262791AbREVU2w>;
	Tue, 22 May 2001 16:28:52 -0400
Message-Id: <200105222013.PAA03768@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Ryan Cumming <bodnar42@bodnar42.dhs.org>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: UML cross-platform build problems (was Re: [PATCH] 
 include/linux/coda.h)
In-Reply-To: Your message of "Tue, 22 May 2001 12:56:26 -0400."
             <20010522125625.A3985@cs.cmu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 May 2001 15:13:52 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jaharkes@cs.cmu.edu said:
> I agree that a UML kernel on FreeBSD should be a native binary and not
> cross-compiled. However, this could be an UML specific problem and
> -D__linux__ should be added to CFLAGS in arch/uml/Makefile

Exactly.  Don't be shy about fiddling CFLAGS in UML-specific Makefiles.  This 
is already done quite a bit (-D__i386__ and the construction of userspace 
CFLAGS are examples).

This is very UML-specific, so there's no reason to bother the rest of the 
kernel (unless, of course, you find a bug that could affect other ports).

				Jeff



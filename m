Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUHPKSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUHPKSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267514AbUHPKSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:18:55 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:40966 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S267515AbUHPKSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:18:36 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Subject: Re: inconsistency in thread/signal interaction in 2.6.5 and =?iso-8859-2?q?previous=09vs=2E_2=2E6=2E6_and_later?= (possibly a bug?)
Date: Mon, 16 Aug 2004 12:18:22 +0200
User-Agent: KMail/1.7
Cc: Glyph Lefkowitz <glyph@divmod.com>, linux-kernel@vger.kernel.org
References: <1092650465.3394.13.camel@localhost> <20040816121136.49bb3fc2@phoebee>
In-Reply-To: <20040816121136.49bb3fc2@phoebee>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408161218.23718.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 of August 2004 12:11, Martin Zwickel wrote:
> On Mon, 16 Aug 2004 06:01:05 -0400
>
> Glyph Lefkowitz <glyph@divmod.com> bubbled:
> > Hello Kernel People,
> >
> > Firstly, here is a brief example of some code that behaves very
> > differently on 2.6.5 and 2.6.6:
> >
> > http://www.twistedmatrix.com/users/glyph/signal-bug.c
> >
> > I have verified that it says "Completed" on kernel 2.6.5, 2.6.3 and
> > 2.6.1, and says "Died" on 2.6.6, 2.6.7 and 2.6.8.1, so I am pretty
> > sure the difference is between 2.5.6 and 2.6.6.
>
> FYI:
> # gcc signal-bug.c -Wall -lutil -lpthread -o signal-bug; ./signal-bug
> Completed.
>
> # cat /proc/version
> Linux version 2.6.8-rc2-mm1 (root@phoebee) (gcc version 3.3.3 20040412
> (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #1 Wed Jul 28 11:39:48
> CEST 2004

# gcc signal-bug.c -Wall -lpthread -lutil -o signal-bug; ./signal-bug
Died.

# cat /proc/version
Linux version 2.6.8 (pluto@vmx) (gcc version 3.4.2 20040806 (prerelease)
(PLD Linux)) #1 Sun Aug 15 19:58:30 CEST 2004

# rpm -q glibc
glibc-2.3.4-0.20040722.2+nptl


-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

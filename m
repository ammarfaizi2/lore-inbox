Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264866AbRFTJSG>; Wed, 20 Jun 2001 05:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbRFTJR4>; Wed, 20 Jun 2001 05:17:56 -0400
Received: from hera.cwi.nl ([192.16.191.8]:30091 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264866AbRFTJRi>;
	Wed, 20 Jun 2001 05:17:38 -0400
Date: Wed, 20 Jun 2001 11:17:24 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106200917.LAA326522.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, vii@users.sourceforge.net
Subject: Re: [PATCH] setuid(2) buggy or bad docs
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> setuid(2) differs from the OpenBSD setuid(2)
> Either I am non compos or the thing is very wrong.
> The docs (man-pages-1.35) say ...

Yes, setuid() has a behaviour that varies a bit from system to system.
Moreover, it has varied in the history of Linux. The manpage may have
been correct when it was written, but it is not today, and I just
fixed it.

ERRORS
       EPERM  The  user  is  not the super-user, and uid does not
              match the real or saved user ID of the calling pro­
              cess.

Our norm is the coming POSIX standard, roughly the Austin 7 draft,
which again is based on the SUSv2. According to this, the current
kernel code is correct here.

Andries

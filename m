Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbREQMrE>; Thu, 17 May 2001 08:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261414AbREQMqy>; Thu, 17 May 2001 08:46:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:34798 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261413AbREQMqn>;
	Thu, 17 May 2001 08:46:43 -0400
Date: Thu, 17 May 2001 14:46:07 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105171246.OAA32815.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: Bug in unlink error return
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMO that's the case of POSIX being misapplied. Rationale:
> * historically, ...

Yes, I know all about that.
Nevertheless the facts are here:

       EPERM  The system does not allow unlinking of directories,
              or unlinking  of  directories  requires  privileges
              that  the  current  process doesn't have.  (This is
              the POSIX prescribed error return.)

       EISDIR pathname refers to a directory.  (This is the  non-
              POSIX value returned by Linux since 2.1.132.)

At first I wrote "buggy" instead of "non-POSIX", but in fact
I prefer EISDIR myself. On the other hand, Linux follows POSIX,
even in the cases where we don't like POSIX very much.

Btw - this change in 2.1.132 actually broke programs, so
at that time is was really the introduction of a bug.

Andries

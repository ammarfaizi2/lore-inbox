Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131254AbRCRRde>; Sun, 18 Mar 2001 12:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131255AbRCRRdY>; Sun, 18 Mar 2001 12:33:24 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38289 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131254AbRCRRdO>;
	Sun, 18 Mar 2001 12:33:14 -0500
Date: Sun, 18 Mar 2001 18:32:30 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103181732.SAA08924.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: pselect
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For people who prefer programming above documenting,
here is a simple small thing to do:

POSIX.1g and Austin document a pselect() call intended to
remove the race condition that is present when one wants
to wait on either a signal or some file descriptor.
(See also Stevens, Unix Network Programming, Volume 1, 2nd Ed.,
1998, p. 168 and the pselect.2 man page released today.)
Glibc 2.0 has a bad version (wrong number of parameters)
and glibc 2.1 a better version, but the whole purpose
of pselect is to avoid the race, and glibc cannot do that,
one needs kernel support.
So, probably someone should make a system call pselect
almost identical to the present select, adding a sigmask
parameter. (Or something more general.)

Andries

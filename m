Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130391AbRAWUmj>; Tue, 23 Jan 2001 15:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbRAWUmU>; Tue, 23 Jan 2001 15:42:20 -0500
Received: from ihemail2.lucent.com ([192.11.222.163]:25828 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S130391AbRAWUmS>; Tue, 23 Jan 2001 15:42:18 -0500
Date: Tue, 23 Jan 2001 14:42:14 -0600
From: Dave Dykstra <dwd@bell-labs.com>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
Message-ID: <20010123144214.A11759@lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <v@iki.fi> suggested I post this bug report here and that
possibly David Miller or Alexey Kuznetsov could help out.  I found the
problem back at the end of October and narrowed it down as much as I could
but didn't know where to report it until now.  For complete details please
see the rsync mailing list archive at
    http://lists.samba.org/pipermail/rsync/2000-October/003004.html
and some of the preceding and following messages.  In particular, the next
message
    http://lists.samba.org/pipermail/rsync/2000-October/003005.html
is an interpretation of the TCP dump by my co-worker which implicates the
Linux side.  Also, in
    http://lists.samba.org/pipermail/rsync/2000-October/002985.html
Andrew Tridgell refers to a TCP patch that went into Linux kernel 2.2.17
and that "Stephen" told him about it but I don't know what Stephen he was
referring to; that fix didn't help anyway.

The first message above refers to a set of data that could possibly be used
to reproduce the problem, but unfortunately nobody else has reported to me
that they have successfully reproduced it.  I only saw the failures when
using rsync to pull to a particular Solaris 7 workstation, but it happened
when pulling from two different Linux machines and three different kernels
but no other type of machine.  Another message
    http://lists.samba.org/pipermail/rsync/2000-October/002981.html
gives a more complete rsync command for reproducing the problem.  The
original report at
    http://lists.samba.org/pipermail/rsync/2000-October/002964.html
says that I first noticed the problem on Linux kernel 2.2.16-3smp.

- Dave Dykstra
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272048AbRIDSP2>; Tue, 4 Sep 2001 14:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272072AbRIDSPT>; Tue, 4 Sep 2001 14:15:19 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:45478 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S272048AbRIDSPJ>; Tue, 4 Sep 2001 14:15:09 -0400
Message-ID: <3B951AA1.648DBB44@kegel.com>
Date: Tue, 04 Sep 2001 11:17:05 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: new solaris syscall: sendfilev
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solaris 8 update 7/01 documents a new system call, sendfilev,
which is like a cross between sendfile and writev.  A copy of
the man page is at http://www.kegel.com/sendfilev.txt

The question immediately comes up - is there an aio version?
I haven't seen one.

Come to think of it, has anyone thought what an aio version of 
plain old writev would look like?  lio_listio() is *unordered*,
but writev is ordered.  I wonder if something like
lio_ordered_listio() would be useful, or if that's just so complicated
it should be done in userland anyway.

- Dan

-- 
"I have seen the future, and it licks itself clean." -- Bucky Katt

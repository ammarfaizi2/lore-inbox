Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267333AbSLEPRo>; Thu, 5 Dec 2002 10:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbSLEPRo>; Thu, 5 Dec 2002 10:17:44 -0500
Received: from mail.ccur.com ([208.248.32.212]:62221 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S267333AbSLEPRm>;
	Thu, 5 Dec 2002 10:17:42 -0500
Message-ID: <3DEF6FC9.AFF1EB0B@ccur.com>
Date: Thu, 05 Dec 2002 10:24:57 -0500
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212042009340.11869-100000@home.transmeta.com> <3DEF20E2.5AEE3E78@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, George,

I like the direction that this ERESTART_RESTARTBLOCK patch is
going.

It might be nice to clear the restart_block.fun in handle_signal()
in the ERESTART_RESTARTBLOCK path which returns -EINTR.  This eliminates 
the chance of a stale restart.

Jim Houston - Concurrent Computer Corp.

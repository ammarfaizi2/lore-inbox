Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbSLDWe1>; Wed, 4 Dec 2002 17:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbSLDWe1>; Wed, 4 Dec 2002 17:34:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9687 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267132AbSLDWeZ>;
	Wed, 4 Dec 2002 17:34:25 -0500
Date: Wed, 04 Dec 2002 14:39:11 -0800 (PST)
Message-Id: <20021204.143911.130515081.davem@redhat.com>
To: george@mvista.com
Cc: dan@debian.org, torvalds@transmeta.com, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DEE822D.385D2664@mvista.com>
References: <20021204205609.GA29953@nevyn.them.org>
	<20021204.140954.89672437.davem@redhat.com>
	<3DEE822D.385D2664@mvista.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: george anzinger <george@mvista.com>
   Date: Wed, 04 Dec 2002 14:31:09 -0800
   
   It might help to understand just what registers do_signal
   needs.  It doesn't need them all, I suspect.

Some of the original register values the process had before
the system call was processed.

I think it's best just to abstract this away properly, as
Linus said to begin with I'd like to note, rather than trying
to come up with a "portable way to call do_signal()".

do_signal is magic and this allows all sorts of great optimizations
and simplifications, please don't add any constraints or complexity
to it.


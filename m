Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277609AbRJHXdM>; Mon, 8 Oct 2001 19:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277607AbRJHXdG>; Mon, 8 Oct 2001 19:33:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16775 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277609AbRJHXcm>;
	Mon, 8 Oct 2001 19:32:42 -0400
Date: Mon, 08 Oct 2001 16:30:54 -0700 (PDT)
Message-Id: <20011008.163054.28787574.davem@redhat.com>
To: davej@suse.de
Cc: alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org, frival@zk3.dec.com,
        paulus@samba.org, Martin.Bligh@us.ibm.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, jay.estabrook@compaq.com,
        rth@twiddle.net
Subject: Re: [PATCH] change name of rep_nop
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0110090120540.5479-100000@Appserv.suse.de>
In-Reply-To: <E15qjdL-0002FT-00@the-village.bc.nu>
	<Pine.LNX.4.30.0110090120540.5479-100000@Appserv.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Jones <davej@suse.de>
   Date: Tue, 9 Oct 2001 01:24:18 +0200 (CEST)
   
   How do you propose to do this without turning setup.c and friends
   into a #ifdef nightmare ? setup_intel.c, setup_amd.c etc ??
   
It is possible to contain the mess in header files.  Other
architectures have done this...

You can either macro inline the cpu tests and/or use function
pointers.  The munging in the header files nops it out into
whatever CONFIG_CPUTYPE was chosen if you didn't ask for the
generic build.

Franks a lot,
David S. Miller
davem@redhat.com

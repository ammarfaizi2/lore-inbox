Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbRENDD6>; Sun, 13 May 2001 23:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262189AbRENDDi>; Sun, 13 May 2001 23:03:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45232 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262187AbRENDDg>;
	Sun, 13 May 2001 23:03:36 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15103.19205.369749.71491@pizda.ninka.net>
Date: Sun, 13 May 2001 20:03:33 -0700 (PDT)
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: "H . J . Lu" <hjl@lucon.org>, alan@lxorguk.ukuu.org.uk,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
In-Reply-To: <m1sni8k9io.fsf@frodo.biederman.org>
In-Reply-To: <20010511162412.A11896@lucon.org>
	<15100.30085.5209.499946@pizda.ninka.net>
	<20010511165339.A12289@lucon.org>
	<m13da9ky7s.fsf@frodo.biederman.org>
	<20010513110707.A11055@lucon.org>
	<m1y9s1jbml.fsf@frodo.biederman.org>
	<20010513181006.A10057@lucon.org>
	<m1sni8k9io.fsf@frodo.biederman.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric W. Biederman writes:
 > Mostly I like the situation where I can compile it in and turn it on
 > when I need it, instead of having to do thing differently if it is
 > compiled in or not.
 > 
 > ip=on is all it really takes.

This is the main reason I like the current 2.4.x behavior.

I hate config options that change how the core of the kernel
boot makes decisions.  Things like "where is root", "what is
my network address or where do I get that information" have
no reasonable default.  This is why the command line args
are there.

If you want a kernel which automatically does "foo", you have
several options already by which to do this:

1) Many platforms allow you to store a boot comand line
   in the firmware (Sparc, several MIPS, PPC, etc.)

2) Failing #1, you can add a default prefix/postfix to the
   kernel command line at build time if you wish, just add
   some simple variable to the toplevel Makefile and have
   init/main.c frob this thing onto the kernel command
   line string after initially fetching it.

Really, H. J., you are asking for a static command line feature.
That's cool, so add it :-)

Later,
David S. Miller
davem@redhat.com

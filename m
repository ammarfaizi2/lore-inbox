Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbQLHDXt>; Thu, 7 Dec 2000 22:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131187AbQLHDXj>; Thu, 7 Dec 2000 22:23:39 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:12994 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131954AbQLHDXX>; Thu, 7 Dec 2000 22:23:23 -0500
Message-ID: <3A304D07.8A0826CC@haque.net>
Date: Thu, 07 Dec 2000 21:52:55 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at buffer.c:827! and scsi modules no load at boot w/ 
 initrd - test12pre7
In-Reply-To: <3A2FF076.946076FC@haque.net> <90p2ds$2hs$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I booted without an initrd defined (still have support compiled in
though) and I didn't get an Oops when I booted. So I guess it's related
to initrd. Here's some more that I noticed..

--snip--
VFS: Mounted root (ext2 filesystem).
kernel BUG at buffer.c:827!
.....Oops.....
Code: 0f 0b 83 c4 0c 8d 73 28 8d 43 2c 39 43 2c 74 15 b9 01 00 00 
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=4
Trying to unmount old root ... <3>error -16
Change root to /initrd: error -2
--snip--

I noticed that there have been changes made to the initrd documention so
I'll look there to see if maybe the mkinitrd script on my system isn't
following something correctly. Unless of course you know of hand of
something else to look at.

Linus Torvalds wrote:
> Do you have something special that triggers this? Can you test if it
> only happens with initrd, for example?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

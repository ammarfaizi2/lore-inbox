Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTJXLHB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 07:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTJXLHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 07:07:01 -0400
Received: from stud4.tuwien.ac.at ([193.170.75.21]:54238 "EHLO
	stud4.tuwien.ac.at") by vger.kernel.org with ESMTP id S262126AbTJXLG7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 07:06:59 -0400
From: Roland Lezuo <roland.lezuo@chello.at>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Re: 2.6.0-test8 mad clock rate drifts and sleeping function ...
Date: Fri, 24 Oct 2003 13:06:45 +0200
User-Agent: KMail/1.5.4
References: <200310231044.46668.roland.lezuo@chello.at> <1066938672.1119.85.camel@cog.beaverton.ibm.com>
In-Reply-To: <1066938672.1119.85.camel@cog.beaverton.ibm.com>
Cc: john stultz <johnstul@us.ibm.com>
X-MSMail-Priority: High
Reply-By: Sat, 18 Oct 2003 08:00:00 +0100
X-message-flag: Outlook says: It is not clever to use me! I'm full of bugs and everyone can hack me!
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310241306.57433.roland.lezuo@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> So you're seeing time run twice as fast overall? Are you running with
> NTP?  Do you have any sort of hardware power management on the system?
> Do you have any more details about the system?

I used to run NTP but I thought I didn't do that when I epxerienced that clock 
drift. The Box (after a restart) is up for 1 day and 13 hours now, there is 
no clock drift any more...
...the xmms problem disappeared by recompileing the xmms-alsa plugin (which is 
strange for me), but it is gone...


the only thing left:

Debug: sleeping function called from invalid context at 
include/asm/uaccess.h:473
in_atomic():0, irqs_disabled():1
Call Trace:
 [<c0120150>] __might_sleep+0xa0/0xd0
 [<c010d40a>] save_v86_state+0x6a/0x200
 [<c010ca67>] do_IRQ+0x117/0x160
 [<c010a49e>] work_notifysig_v86+0x6/0x14
 [<c010a44b>] syscall_call+0x7/0xb

... there are more of this called from different source files...

greetings
roland lezuo
- -- 
PGP Key ID: 0xFCC9ED1E
http://members.chello.at/roland.lezuo/ <- l337 zup4 h4x0r 4nd c0d3r h0meb4se
root@server:/ >mount -t inetfs /dev/inet /mnt/tmp
root@server:/ >rm -rf /mnt/tmp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/mQfP5qlVDPzJ7R4RAvkGAJ9ZgJ6HZibG73HzOi8jUoKb7S6QowCbBm89
iCMYG0CXzzl0nAWQR9lSCvY=
=Pwop
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263033AbRFJBoJ>; Sat, 9 Jun 2001 21:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbRFJBn7>; Sat, 9 Jun 2001 21:43:59 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:28073 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263033AbRFJBns>; Sat, 9 Jun 2001 21:43:48 -0400
Message-ID: <3B22CEF9.6DEB1A66@uow.edu.au>
Date: Sun, 10 Jun 2001 11:35:53 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hofmang@ibm.net
CC: linux-kernel@vger.kernel.org
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B221A56.31120.3C1910@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Glenn C. Hofmann" wrote:
> 
> I have tried 2.4.5-pre2 up to 2.4.6-pre1 with the same results.  Everything boots
> great and I can login fine.  When I try to assign an IP via DHCP or ifconfig, the system
> sits and stares at me indefinitely.  2.4.5-pre4 didn't compile for me, but pre3 works fine
> and pre5 locks.  There is keyboard response, and Alt-SysRq will tell me that it knows I
> want it to sync the disks, but won't actually do it.  It will reboot, though.  I can switch
> between terminals, but cannot type anything at the login prompt.
> 
> The board is a Abit KT7-RAID.  I have waited to see if this issue has been resolved and
> will recompile the newer kernels (AC and Linus flavours) to see if it has cleared up, but
> wanted to see if maybe there is something else I should look at.  I can provide any more
> information that might help, so please let me know.  Thanks in advance.

There's a problem in some versions of `pump' where it gets
confused and ends up spinning indefinitely.  If you're using
pump could you please try the latest RPM?

If that doesn't help, and if you're unable to kill pump
with ^C, and if other virtual consoles are not responding then
it could be a kernel problem - try hitting sysrq-T and feeding
the resulting logs through `ksymoops -m System.map'

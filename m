Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQJ3PpP>; Mon, 30 Oct 2000 10:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129239AbQJ3PpG>; Mon, 30 Oct 2000 10:45:06 -0500
Received: from po3.wam.umd.edu ([128.8.10.165]:56507 "EHLO po3.wam.umd.edu")
	by vger.kernel.org with ESMTP id <S129074AbQJ3Poz>;
	Mon, 30 Oct 2000 10:44:55 -0500
Message-ID: <39FD9765.F4DDE539@haque.net>
Date: Mon, 30 Oct 2000 10:44:37 -0500
From: Mohammad Haque <mhaque@haque.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Pierre Etchemaite <petchema@concept-micro.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide/disk perf?
In-Reply-To: <39FCB13E.6267C38D@haque.net> <XFMail.20001030130943.petchema@concept-micro.com> <39FD7D0B.E957CA7D@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting theory, but no go here.

I just remembered one other thing that may have an impact. I have a
IBM-DTLA-307045 (~45 GB i think) hanging off the same channel as slave.
The thing with that one is that if I try to do a lot of i/o on the
disk..my machine locks up. Hard. alt-sysReq doesn't even work.

I'll try disconnecting that drive when I get a chance but I welcome any
feedback/theories before I get home to do this. 

Andrew Morton wrote:
> 
> I had the same problem with Seagate ST313021A (13 gig) drives on
> BP6/HPT366/UDMA66.  Initial throughput reported by `hdparm -t' was 22
> megs/sec which would slowly wilt to 5 megs/sec.
> 
> I discovered that sending _any_ reconfiguration command to the drive -
> even one which was not supported by that particular drive - would bring
> the performance back.
> 
> So when it goes slow, try running, say, `hdparm -A1' and see what
> happens.
> 
> Andre and I scratched each others heads for a while, suspected a
> firmware bug.  He sent an email to a contact at Seagate.  This was in
> April, so I guess that person is a very slow typist.

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

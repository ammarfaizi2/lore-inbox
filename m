Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQJ3NxD>; Mon, 30 Oct 2000 08:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129077AbQJ3Nwo>; Mon, 30 Oct 2000 08:52:44 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:55772 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129040AbQJ3Nwk>; Mon, 30 Oct 2000 08:52:40 -0500
Message-ID: <39FD7D0B.E957CA7D@uow.edu.au>
Date: Tue, 31 Oct 2000 00:52:11 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierre Etchemaite <petchema@concept-micro.com>
CC: "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide/disk perf?
In-Reply-To: <39FCB13E.6267C38D@haque.net> <XFMail.20001030130943.petchema@concept-micro.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Etchemaite wrote:
> 
> Le 30-Oct-2000, Mohammad A. Haque écrivait :
> > Could someone who knows ide and drive inside and out (Andre?) please
> > take a look at these figures? Am I forgetting to do something (or doing
> > something I'm not suposed to) to get the best numbers? I thought I'd be
> > able to get more than ~4MB/sec off the HPT366 and a UDMA66 drive.
> 
> It could be unrelated, but I had problems several times with Maxtor drives
> recently; Their performances are usually high (some models give >20 Mb/s
> both reads and writes), but under some conditions that I couldn't narrow down
> yet, the read throughput is stuck to the floor (a few megabytes/sec) until
> next reboot. The write performance is always ok.

I had the same problem with Seagate ST313021A (13 gig) drives on
BP6/HPT366/UDMA66.  Initial throughput reported by `hdparm -t' was 22
megs/sec which would slowly wilt to 5 megs/sec.

I discovered that sending _any_ reconfiguration command to the drive -
even one which was not supported by that particular drive - would bring
the performance back.

So when it goes slow, try running, say, `hdparm -A1' and see what
happens.

Andre and I scratched each others heads for a while, suspected a
firmware bug.  He sent an email to a contact at Seagate.  This was in
April, so I guess that person is a very slow typist.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

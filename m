Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287895AbSAHFNB>; Tue, 8 Jan 2002 00:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287648AbSAHFMs>; Tue, 8 Jan 2002 00:12:48 -0500
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:65030
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S287896AbSAHFLo>; Tue, 8 Jan 2002 00:11:44 -0500
From: "Phil Oester" <kernel@theoesters.com>
To: "'Stephan von Krawczynski'" <skraw@ithnet.com>
Cc: <linux-kernel@vger.kernel.org>, "'M.H.VanLeeuwen'" <vanl@megsinet.net>
Subject: RE: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Date: Mon, 7 Jan 2002 21:11:42 -0800
Message-ID: <000301c19802$f5ec5fb0$6400a8c0@philxp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20020107152422.42cfb554.skraw@ithnet.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vmscan patch doesn't seem to help in the 'make -j' testcase.  

Here's time of a couple runs:

2.4.17 vanilla

real    32m2.097s
user    9m51.800s
sys     3m47.700s

real    19m45.696s
user    9m55.820s
sys     2m32.170s

2.4.17 + vmscan patch

gave up waiting after 2 hours...never finished.

Unfortunately, box was not responsive enough to gather any useful
information.  Perhaps not swapping enough???

-Phil

-----Original Message-----
From: Stephan von Krawczynski [mailto:skraw@ithnet.com] 
Sent: Monday, January 07, 2002 6:24 AM
To: Phil Oester
Cc: nknight@pocketinet.com; linux-kernel@vger.kernel.org
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM


On Sun, 6 Jan 2002 22:22:16 -0800
"Phil Oester" <kernel@theoesters.com> wrote:

> I've rerun this test a number of times, and cannot reliably reproduce
> the OOM - though it still does OOM occasionally.  It never OOM's right
> after a bootup - usually the greatest chance of OOM is after 2 or 3
> consecutive runs without a reboot.  Once it even froze the box and
> required a powercycle.
> 
> I'm surprised you cannot OOM with 1gb RAM/256MB swap, as sometimes I'm
> over 900MB in swap - did you try consecutive runs, or just once and
then
> reboot between each run?

I tried just about everything I could think of and it never went in OOM.
Even
the first test I did were with several days uptime - meaning far away
from
"cleaning" reboot. I hate reboot :-)

> [...]
> Haven't yet tried Martin's patch - though since I can't reliably
produce
> the OOM, testing it wouldn't help much.

Well, take the other side: if you do not manage to OOM afterwards, even
at the
tenth consecutive try, there is probably something about the patch ...

Regards,
Stephan




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286375AbSAGGWn>; Mon, 7 Jan 2002 01:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286386AbSAGGWd>; Mon, 7 Jan 2002 01:22:33 -0500
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:35846
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S286375AbSAGGWR>; Mon, 7 Jan 2002 01:22:17 -0500
From: "Phil Oester" <kernel@theoesters.com>
To: "'Stephan von Krawczynski'" <skraw@ithnet.com>
Cc: <nknight@pocketinet.com>, <linux-kernel@vger.kernel.org>
Subject: RE: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Date: Sun, 6 Jan 2002 22:22:16 -0800
Message-ID: <000101c19743$a6dc4120$6400a8c0@philxp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20020105161727.18f04fc3.skraw@ithnet.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've rerun this test a number of times, and cannot reliably reproduce
the OOM - though it still does OOM occasionally.  It never OOM's right
after a bootup - usually the greatest chance of OOM is after 2 or 3
consecutive runs without a reboot.  Once it even froze the box and
required a powercycle.

I'm surprised you cannot OOM with 1gb RAM/256MB swap, as sometimes I'm
over 900MB in swap - did you try consecutive runs, or just once and then
reboot between each run?

On a side note, there seems to be some debate as to whether this is a
valid test.  The detractors primarily claim that 'make -j' just
overloads the machine with too many processes and therefore is setting
it up to fail.  My position has always been that the kernel
_should_not_OOM_ under this test due to the ~2gb of ~RAM being thrown at
it.  It may die for any number of other reasons, but OOM shouldn't be
one of them.  In other words, either the OOM killer may be too
aggressive here, or the kernel isn't reclaiming inactive RAM under heavy
load.

Haven't yet tried Martin's patch - though since I can't reliably produce
the OOM, testing it wouldn't help much.

-Phil Oester


-----Original Message-----
From: Stephan von Krawczynski [mailto:skraw@ithnet.com] 
Sent: Saturday, January 05, 2002 7:17 AM
To: Phil Oester
Cc: nknight@pocketinet.com; linux-kernel@vger.kernel.org
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM

I guess this testcase is somewhat driving in the direction of Martins
test with
some setis running, meaning it has a lot of standard processes that need
files
and try to work out something. Can you try Martins patch at your side,
redo the
-j story and give us a result? I attached it for an easy go :-)

Thanks,
Stephan



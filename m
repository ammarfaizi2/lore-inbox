Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbRAOCAY>; Sun, 14 Jan 2001 21:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAOCAO>; Sun, 14 Jan 2001 21:00:14 -0500
Received: from 167-ZARA-X31.libre.retevision.es ([62.82.236.167]:27397 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S129931AbRAOCAE>;
	Sun, 14 Jan 2001 21:00:04 -0500
Message-ID: <3A6259AF.81DF16EE@zaralinux.com>
Date: Mon, 15 Jan 2001 03:00:15 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease-diff i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: Ingo Molnar <mingo@elte.hu>, Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <20010112214642.A27809@unternet.org> <Pine.LNX.4.30.0101122150260.3128-100000@e2> <20010112220523.C27809@unternet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank de Lange wrote:
> 
> On Fri, Jan 12, 2001 at 09:51:36PM +0100, Ingo Molnar wrote:
> > great. Back when i had the same problem, flood pinging another host (on
> > the local network) was the quickest way to reproduce the hang:
> >
> >       ping -f -s 10 otherhost
> >
> > this produced an IOAPIC-hang within seconds.
> 
> Apart from killing streaming audio and interactive network use, nothing hangs.
> As soon as the ping flood is stopped, audio streams on and ssh sessions are
> useable again. So, it seems to fix it...
> 
> Frank

I do have a 3c503 and a ne2k-pci both of them use the 8390, I can hang
the ne2k-pci easily by doing a ping -f, bigger packet size => early the
hang. But I cannot hang the 3c503 by doing this.

Now with 2.4.0 the ne2k-pci behaviour is that: doing a ping -f works for
some amount of time, then stops for a BIG amount of time (various
minutes), and then it works again (it seems), but at a much slower
speed, and if you test it with normal ping (ping host) you don't get
replies.

The packets really go down to the wire and I even got replies. but I
don't receive it.

Previous versions of 2.4.0-testX caused ne2k-pci to hang and remain
hanged until reboot.

System: Mb Gigabyte 586dx, 2x200MMX, 96Mb RAM,

-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

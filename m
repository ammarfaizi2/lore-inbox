Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281246AbRKLFPe>; Mon, 12 Nov 2001 00:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281253AbRKLFPY>; Mon, 12 Nov 2001 00:15:24 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6931 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281246AbRKLFPK>; Mon, 12 Nov 2001 00:15:10 -0500
Message-ID: <3BEF5ABB.78254C5F@zip.com.au>
Date: Sun, 11 Nov 2001 21:14:35 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: hogsberg@users.sourceforge.net, jamesg@filanet.com,
        Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au>,
		<3BEF27D1.7793AE8E@zip.com.au>; from akpm@zip.com.au on Sun, Nov 11, 2001 at 05:37:21PM -0800 <20011111205411.B30782@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H . J . Lu" wrote:
> 
> > Incidentally, it would be nice to be able to get this driver working
> > properly when linked into the kernel - it makes debugging much easier :)
> >
> 
> I guess I can try that. The only main issue will be the order of
> initialization.
> 

Actually, it almost works.  If you link the drivers into the kernel
and, after bootup, attach a firewire drive and run rescan-scsi-bus.sh
it will pick up the new devices.  It's just the bus scan at initcall
time which fails.

-

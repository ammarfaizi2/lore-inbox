Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbQJ3G54>; Mon, 30 Oct 2000 01:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQJ3G5p>; Mon, 30 Oct 2000 01:57:45 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:40521 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129035AbQJ3G52>; Mon, 30 Oct 2000 01:57:28 -0500
Date: Mon, 30 Oct 2000 08:57:20 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: eepro100: card reports no resources [was VM-global...]
Message-ID: <20001030085720.E1248@niksula.cs.hut.fi>
In-Reply-To: <20001026193508.A19131@niksula.cs.hut.fi> <20001030142356.A3800@saw.sw.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20001030142356.A3800@saw.sw.com.sg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 02:23:56PM +0800, you [Andrey Savochkin] claimed:
> Hello,
> 
> On Thu, Oct 26, 2000 at 07:35:08PM +0300, Ville Herva wrote:
> > Markus Pfeiffer <profmakx@profmakx.de> wrote:
> > > 
> > > > Oct 26 11:24:13 ns29 kernel: eth0: card reports no resources.
> > > > Oct 26 11:24:15 ns29 kernel: eth0: card reports no resources.
> > > > Oct 26 12:22:21 ns29 kernel: eth0: card reports no resources.
> > > > Oct 26 16:16:59 ns29 kernel: eth0: card reports no resources.
> > > > Oct 26 16:28:37 ns29 kernel: eth0: card reports no resources.
> > > > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.
> > > > 
> > > let me guess: intel eepro100 or similar??
> > > Well known problem with that one. dont know if its fully fixed ... With
> > 
> > Happens here too, with 2xPPro200, 2.2.18pre17, Eepro100 and light load.
> > The network stalls for several minutes when it happens.
> > 
> > > 2.4.0-test9-pre3 it doesnt happen on my machine ...
> > 
> > What about a fix for a 2.2.x...?
> 
> The exact reason for this problem is still unknown.

I have to take some of what I said back. The network stalls were actually       
due to a lot more stupid problem: the server went into a power saving           
state and the NIC IRQ didn't wake it up (mouse did). After I disabled the       
the relevant stupidnesses from the BIOS setup, it now works.                    
                                                                                
The error message, however, does appear with the 2.2.18pre17 eepro100.c,        
while as the Becker's version does not show it for whatever reason.             


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

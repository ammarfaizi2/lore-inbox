Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293596AbSDUEMz>; Sun, 21 Apr 2002 00:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSDUEMy>; Sun, 21 Apr 2002 00:12:54 -0400
Received: from w226.z064000207.nyc-ny.dsl.cnc.net ([64.0.207.226]:56369 "EHLO
	carey-server.stronghold.to") by vger.kernel.org with ESMTP
	id <S293596AbSDUEMx>; Sun, 21 Apr 2002 00:12:53 -0400
Message-Id: <4.3.2.7.2.20020421001408.03b75bc0@mail.strongholdtech.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 21 Apr 2002 00:18:12 -0400
To: Chris Abbey <linux@cabbey.net>, <linux-kernel@vger.kernel.org>
From: "Nicolae P. Costescu" <nick@strongholdtech.com>
Subject: Re: PDC20268 TX2 support?
In-Reply-To: <Pine.LNX.4.33.0204201226530.25636-100000@tweedle.cabbey.ne
 t>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fasttrak tx2 (we have lots of them) and things like Highpoint RocketRaid 
133 really are not hardware raid, from what I understand. They have some 
bios assist functions but the CPU does a lot of the work.

3ware makes hardware raid cards. We switched to them - you can get a nice 2 
channel one that blows the Fastrak tx2 and RocketRaid 133 away on 
performance for $145  ($245 for the 4 channel 2 meg cache raid 1/10/5/jbod 
model). My simple write 2 gig read 2 gig benchmark ran 50% faster  with the 
3ware product than with the other 2 products.  Performance increases were 
seen on KT133A athlon, i845 p4, and AMD MPX dual athlon systems. And the 
3ware product has full driver source, and obviously full kernel support (we 
use the drivers that are part of the 2.4.18 kernel). Not to mention the 
3ware people know linux. We were able to ask them questions that would send 
Promise and Highpoint tech support people running.

We had to switch to 3ware because Promise and Highpoint wouldn't provide a 
driver for anything other than 2.4.2/2.4.7 and wouldn't provide source. 
Glad we did all around.

At 12:33 PM 4/20/2002 -0500, Chris Abbey wrote:
>Today, Alan Cox wrote:
> > > the 2.4.19 timeframe. I'm curious what level of support folks are
> > > expecting? Just basic IDE, or support for the hardware raid features?
> >
> > What hardware raid features ?
>
>The FastTraK 100 TX2 has hardware raid (stripe/mirror) support, they
>have a binary only driver (scsi/ft.o) which presents this array as
>a scsi device... this is the level of function I was hoping was being
>integrated.
>
> > AFAIK their only cards with hardware raid features are the supertrak 
> 100 and
> > SX6000.
>
>The fasttrak also has hardware raid, while it works, it works realtively
>well.
>
>The current 2.4.18 code recognizes the card and provides vanilla IDE
>access to the drives, unfortunately that isn't much use unless someone
>wants to try and RE their block allocation on the disks... a decidedly
>non-trivial endeavour I can assure you. ;(
>
>--
>Never make a technical decision based upon the politics of the situation.
>Never make a political decision based upon technical issues.
>The only place these realms meet is in the mind of the unenlightened.
>                         -- Geoffrey James, The Zen of Programming
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

****************************************************
Nicolae P. Costescu, Ph.D.  / Senior Developer
Stronghold Technologies
46040 Center Oak Plaza, Suite 160 / Sterling, Va 20166
Tel: 571-434-1472 / Fax: 571-434-1478


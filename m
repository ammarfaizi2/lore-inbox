Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129637AbQJZVbA>; Thu, 26 Oct 2000 17:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbQJZVav>; Thu, 26 Oct 2000 17:30:51 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:31759 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129637AbQJZVan>; Thu, 26 Oct 2000 17:30:43 -0400
Date: Thu, 26 Oct 2000 23:37:07 +0000
From: Heinz.Mauelshagen@t-online.de (Heinz J. Mauelshagen)
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-lvm@msede.com, mge@sistina.com
Subject: Re: LVM snapshotting broken?
Message-ID: <20001026233707.A12201@srv.t-online.de>
Reply-To: Mauelshagen@sistina.com
In-Reply-To: <Pine.LNX.4.21.0010261632440.15696-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010261632440.15696-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Oct 26, 2000 at 04:36:37PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rik,

I can't reproduce it on my box.

Could you provide a "lvcreate -d" output of what you did to help
me to dig into that one.

Did somebody else out there face the same 0.8final snapshot weirdness?


On Thu, Oct 26, 2000 at 04:36:37PM -0200, Rik van Riel wrote:
> Hi Heinz,
> 
> it looks like the LVM snapshotting in 2.4 doesn't allow you
> to create snapshots from anything else than the _first_ LV
> in the VG...
> 
> I have run both the following command lines (after lvremoving
> snap1, of course) and both of them give as a result that the
> LV /dev/test_vg/swap ends up being the snapshotted filesystem ;(
> 
> # lvcreate -s -L100 -nsnap1 /dev/test_vg/test
> # lvcreate -s -L100 -nsnap1 /dev/test_vg/swap
> 
> # cat /proc/lvm
> LVM driver version 0.8final  (15/02/2000)
> 
> 	<snip VG/PV info>
> 
>     LVs: [AWDL  ] swap            122880 /30       1x open
>          [AWDL  ] test            204800 /50       1x open
>          [ARDL  ] snap1           122880 /30       close
> 
> It looks like somewhere in either the utilities or the
> kernel, the argument of which LV to snapshot gets mangled...
> Oh, I'm using version 0.8final of the LVM utities.
> 
> regards,
> 
> Rik
> --
> "What you're running that piece of shit Gnome?!?!"
>        -- Miguel de Icaza, UKUUG 2000
> 
> http://www.conectiva.com/		http://www.surriel.com/

-- 

Regards,
Heinz      -- The LVM guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Bartningstr. 12
                                                  64289 Darmstadt
                                                  Germany
Mauelshagen@Sistina.com                           +49 6151 7103 86
                                                       FAX 7103 96
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

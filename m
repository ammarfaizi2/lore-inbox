Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132376AbRA2Qs5>; Mon, 29 Jan 2001 11:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135286AbRA2Qsq>; Mon, 29 Jan 2001 11:48:46 -0500
Received: from md.aacisd.com ([64.23.207.34]:275 "HELO md.aacisd.com")
	by vger.kernel.org with SMTP id <S132376AbRA2Qsk>;
	Mon, 29 Jan 2001 11:48:40 -0500
Message-ID: <8FED3D71D1D2D411992A009027711D67185B@md>
From: Nathan Black <NBlack@md.aacisd.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Bolck Device problem or Compaq Smart array 2 problem? kernel 
	-2.4 .0+
Date: Mon, 29 Jan 2001 11:44:06 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It comes back with a command prompt. trying a "simple command... ps, ls
it does not return. The hard disks(hardware raid) light up. But it seems
like noone is home.
It doesn't oops in the 2.4.1-pre11 or 10.
That is a good thing.



-----Original Message-----
From: Jens Axboe [mailto:axboe@suse.de]
Sent: Monday, January 29, 2001 11:38 AM
To: Nathan Black
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bolck Device problem or Compaq Smart array 2 problem?
kernel -2.4 .0+


On Mon, Jan 29 2001, Nathan Black wrote:
> Here are my results.
> 
> 2.2.18- works fine. 24 MBytes/sec at 100+ gigabytes (16GB looped many
times
> ( lseek64(FD,SEEK_SET,0) )).
> 
> 2.4.0 release SMP and Uniprocessor with NMI on-	Kernel oops. I can
reproduce
> if necessary( oops at about 700 MB)  sometimes more, sometime less. (In
> BDFLUSH if I recall)
> 
> 2.4.0 release UniProcessor NMI off- Works like the 2.2.18
> 
> 2.4.1-pre10 & 11- Works but system becomes unusable(requires reboot) after
> completing.

Unusable how? Does it hang or oops? Does nmi and up/smp make any
differences in 2.4.1-preXX?

I did some fixes for cpq after the blk merge in 2.4.1-pre, and got
reports that it works. However, I don't have the necessary hardware
to test myself.

-- 
Jens Axboe
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

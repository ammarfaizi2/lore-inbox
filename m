Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157607-27302>; Sat, 30 Jan 1999 19:31:03 -0500
Received: by vger.rutgers.edu id <157407-27300>; Sat, 30 Jan 1999 19:25:54 -0500
Received: from frank.watsons.edin.sch.uk ([194.217.6.7]:4874 "EHLO frank.watsons.edin.sch.uk" ident: "root") by vger.rutgers.edu with ESMTP id <157402-27300>; Sat, 30 Jan 1999 19:24:20 -0500
Date: Sun, 31 Jan 1999 00:35:51 +0000 (GMT)
From: Alistair Riddell <alistair@watsons.edin.sch.uk>
To: System Administrator <admin@intergrafix.net>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: resizing swap partition? maybe off-topic
In-Reply-To: <Pine.LNX.4.05.9901271040230.26295-100000@athena.intergrafix.net>
Message-ID: <Pine.LNX.3.96.990131003217.29851A-100000@frank.watsons.edin.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

I believe Ted T'so (sp) wrote an ext2fs resizing program whicih is
available commerically as part of Partition Magic. AFAIK there is no
freely available program to do this.

You could simply create a swapfile on /dev/sda3 of the desired size and
use it concurrently with your swap partition (there is no problem with
having more tan one swap device active). As you say there is a slight
performance disadvantage with swap files over swap partitions but I doubt
if you would notice the difference.

On Wed, 27 Jan 1999, System Administrator wrote:

> 
> ok, the last 2 partitions on my drive are this..
> 
> Disk /dev/sda: 255 heads, 63 sectors, 1106 cylinders
> /dev/sda3          639      639     1101  3719047+  83  Linux native
> /dev/sda4         1024     1102     1106    40162+  82  Linux swap
> 
> is there any way I can take a chunk off the end of sda3 and then
> remake my sda4 to be like 128MB? Without destroying the current info on
> sda3.
> 
> someone suggested just making a swapFILE on sda3 instead with mkswap.
> would there be any performance difference? if not, could i tack my unused
> sda4 onto sda3 then or would i have to mount it under a specific
> directory to reuse it again?
> 
> Thanx,
> 
> -Tony
> .-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
> Anthony J. Biacco                       Network Administrator/Engineer
> admin@intergrafix.net                    Intergrafix Internet Services
> 
>     "Dream as if you'll live forever, live as if you'll die today"
> http://cygnus.ncohafmuta.com                http://www.intergrafix.net
> .-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
Alistair Riddell - BOFH
IT Support Department, George Watson's College, Edinburgh
Tel: +44 131 447 7931 Ext 176       Fax: +44 131 452 8594
Microsoft - because god hates us


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

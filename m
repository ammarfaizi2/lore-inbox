Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135172AbRDRNZ2>; Wed, 18 Apr 2001 09:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135173AbRDRNZS>; Wed, 18 Apr 2001 09:25:18 -0400
Received: from smtp1.sentex.ca ([199.212.134.4]:16901 "EHLO smtp1.sentex.ca")
	by vger.kernel.org with ESMTP id <S135172AbRDRNZE>;
	Wed, 18 Apr 2001 09:25:04 -0400
Message-ID: <3ADD959F.B5C90619@coplanar.net>
Date: Wed, 18 Apr 2001 09:24:48 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: Tim Peeler <tim@iss.dccc.edu>, linux-kernel@vger.kernel.org
Subject: Re: I can eject a mounted CD
In-Reply-To: <XFMail.010418111741.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

> >> >> That's not the point. The kernel should not allow someone to
> >> >> eject a mounted media.
> >> >
> >> > rpm -e magicdev
> >>
> >> Magicdev is not installed.
> >> Ok, I'm the only one with this problem, I'll manage to find the bug by myself.
> >
> > eject(1) line 36:
> >
> >    If the device is currently mounted, it is unmounted before
> >    ejecting.
>
> But it doesn't get unmounted. I eject the disk but I can still see
> and read the (cached) files !
>
> Bye.
>     Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

hdparm has an option controlling door locking; try locking it manually
to see if the drive can even lock the door.  then try setting it
to match mounted/unmounted status of device;  maybe it defaults
to always unlocked for some reason.

hdparm -L 1 /dev/hdc

also try commenting out one of those fstab lines... may be confusing things.
it should work the way you have it - you say mount /mnt/fstype and
depending of fstype it picks the right line, but just for the sake of debugging
try loosing one temporarily.

Cheers


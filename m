Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154372-8316>; Wed, 9 Sep 1998 11:00:45 -0400
Received: from warden.diginsite.com ([208.29.163.2]:61610 "EHLO mail.diginsite.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154531-8316>; Wed, 9 Sep 1998 10:06:36 -0400
Date: Wed, 9 Sep 1998 09:35:59 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Andrej Presern <andrejp@luz.fe.uni-lj.si>
cc: majordomo@vger.rutgers.edu, Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>, linux-kernel@vger.rutgers.edu
Subject: Re: GPS Leap Second Scheduled!
In-Reply-To: <98090822315400.00819@soda>
Message-ID: <Pine.LNX.4.03.9809090934220.7567-100000@dlang>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

-----BEGIN PGP SIGNED MESSAGE-----

I am probably missing something, but can't you just ignore the leap second
until you discover that the time is 1 sec off and then use the normal NTP
procedure to get back to the exact time

David Lang

On Tue, 8 Sep 1998, Andrej Presern wrote:

> Date: Tue, 8 Sep 1998 22:27:28 +0200
> From: Andrej Presern <andrejp@luz.fe.uni-lj.si>
> To: majordomo@vger.rutgers.edu,
     Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
> Cc: linux-kernel@vger.rutgers.edu
> Subject: Re: GPS Leap Second Scheduled!
> 
> On Mon, 07 Sep 1998, Ulrich Windl wrote:
> >(...About leap second handling in the Linux kernel...)
> >On 1 Sep 98, at 11:16, Sven Dietrich wrote:
> >> The GPS control segment has posted a leap second warning for week number
> >> 990, Day number 5, and thus it's official in GPS world,
> >> that the leap second will take place 12/31/98... 
> >> 
> >> I am going to run simulations on NTP 3 & 4 and Linux with that GPS almanac. 
> >> Will send bug fixes and patches as needed for the Trimble refclocks and
> >> NTP...
> >> 
> >> Linux currently inserts a 2nd 59th second, instead of the UTC model of ...
> >> 58, 59, 60...
> >
> >The time in the kernel is seconds since the epoch. To insert a second 
> >means that we'll have to delay the next second for another second. 
> >The other solution seems to be a clib -> kernel interface that knows 
> >that a leap second is active now. Then the clib could possibly 
> >convert the seconds to xx:yy:60. (I hope I did not overlook something 
> >obvious).
> 
> Have you considered simply not scheduling any processes for one second and
> adjusting the time accordingly? (if one second chunk is too big, you can do it
> in several steps)
> 
> Andrej
> 
> --
> Andrej Presern, andrejp@luz.fe.uni-lj.si
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/faq.html
> 

-----BEGIN PGP SIGNATURE-----
Version: PGP for Personal Privacy 5.0
Charset: noconv

iQEVAwUBNfaucj7msCGEppcbAQGFkQf/WSuUbkLPd2sfQ99FgjoOcRox47ZUV6rr
c6Yj6rfIhMXpCqzRcqyNa7JS3mTK+8Z3/9Pu1WbEU/MdZrgvvorCyq9k795V8tr6
GX2EqEoVt87uhAiBRdzMi9XREsWi8hTK/yr0RRAQKhP/bLcGvjcrmDvlUR6fEBic
jo026QXPYN4mIhyf6kIyXBmrh9dOr9EFvYYz7Lr13nwa9NjA5tlOOoSDDmG8tobz
hmgRcSE93OJgoVDwOwUcgC2thH6x0MBMYCfp/c2TWQ9cYaI4dVTlEeJWKjQTTp2I
hDsW/RjLWycR5k7PnRV002Lm6+Dxxl/ajwINgpm0S52qDJleAo+eUw==
=pxxv
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280783AbRKLHYC>; Mon, 12 Nov 2001 02:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281292AbRKLHXx>; Mon, 12 Nov 2001 02:23:53 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:27282 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S280783AbRKLHXs>; Mon, 12 Nov 2001 02:23:48 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org, steve@uhura.rueb.com
Date: Sun, 11 Nov 2001 22:59:25 -0800 (PST)
Subject: Re: Best kernel config for exactly 1GB ram 
In-Reply-To: <Pine.LNX.4.33.0111120830140.1901-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.40.0111112249470.3451-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I leave mine at the 1G settings, it gives me 960MB instead of 1024M but
avoids all the potential problems that show up with himem.

there are still a lot of potential problems with himem (see linus' post
last week about the pitfalls of locking memory on himem machines in the
wrong zone for one example)

those potential problems are worth dealing with if you really do need a
lot of ram, but the difference between 960M and 1024M doesn't seem like
enough benifit to be worth it. If you really need every bit of your ram
you should not be running X and should shut down a LOT of the default
services, if you haven't gone through and optimized your system you can
probably free up more then 64M of ram that way.

David Lang


On Mon, 12 Nov 2001, Zwane Mwaikambo wrote:

> Date: Mon, 12 Nov 2001 08:38:29 +0200 (SAST)
> From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
> To: linux-kernel@vger.kernel.org
> Cc: steve@uhura.rueb.com
> Subject: Best kernel config for exactly 1GB ram
>
> you actually lose about 128Mb ram (128Mb HIGHMEM) if you don't specify the
> 4gig option, and you might find that you'd rather have the extra memory
> than the "noticeable?" slowdown. I set all my 1G boxes to 4G mostly because
> i put that amount of ram because i need every bit.
>
> Regards,
> 	Zwane Mwaikambo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

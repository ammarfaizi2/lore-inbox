Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbTDHXCa (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTDHXCa (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:02:30 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:43718 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S262526AbTDHXC1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 19:02:27 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Date: Tue, 8 Apr 2003 16:11:05 -0700 (PDT)
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030408195305.F19288@almesberger.net>
Message-ID: <Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the biggest problem I see with dynamic numbers is that it needs a
userspace devfs type solution for creating and maintaining the device
nodes that are then used. While this isn't rocket science it's also
somthing that is hard to get people to agree to (remember the devfs names
that everyone gripes about are not what richard started with it's what he
switched to to get things into the kernel, they changed many times during
that process)

I don't think many people will argue that dynamic assignments are evil,
but I think you will find a lot of people very nervous about switching to
them and the risk involved with doing so.

David Lang


 On Tue, 8 Apr 2003, Werner Almesberger wrote:

> Date: Tue, 8 Apr 2003 19:53:05 -0300
> From: Werner Almesberger <wa@almesberger.net>
> To: Roman Zippel <zippel@linux-m68k.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 64-bit kdev_t - just for playing
>
> Roman Zippel wrote:
> > Date:   Mon, 7 Apr 2003 22:10:11 +0200 (CEST)
> [...]
> > Date: 	Mon, 7 Apr 2003 23:57:56 +0200 (CEST)
> [...]
> > Ok, Peter refuses to give me an answer to that,
>
> That was a quick conclusion, after less than two hours :-)
>
> Anyway, I agree with your general concern. It only seems good
> engineering practice to also look at the numbering schemes that
> are supposed to go with the device number enlargement.
>
> Or, alternatively, to make sure that it's trivial to make further
> enlargements (or shrinkages), if the need for them should arise.
> I didn't look at the issue in detail, but perhaps the latter is
> the case ?
>
> - Werner
>
> --
>   _________________________________________________________________________
>  / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
> /_http://www.almesberger.net/____________________________________________/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbTBREth>; Mon, 17 Feb 2003 23:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTBREth>; Mon, 17 Feb 2003 23:49:37 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:32949 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S267597AbTBREtg>; Mon, 17 Feb 2003 23:49:36 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Mark J Roberts <mjr@znex.org>, linux-kernel@vger.kernel.org
Date: Mon, 17 Feb 2003 20:58:40 -0800 (PST)
Subject: Re: Annoying /proc/net/dev rollovers.
In-Reply-To: <20030217103553.GH1073@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0302172057170.656-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

don't forget that 10G ethernet is starting to leak out of the labs into
the real world. I don't know of any linux support yet, but it will come
and then you will be able to overflow 32bit bitcounters multiple times per
second.

David Lang


 On Mon, 17 Feb 2003, Matti Aarnio wrote:

> Date: Mon, 17 Feb 2003 12:35:53 +0200
> From: Matti Aarnio <matti.aarnio@zmailer.org>
> To: Mark J Roberts <mjr@znex.org>, linux-kernel@vger.kernel.org
> Subject: Re: Annoying /proc/net/dev rollovers.
>
> On Sun, Feb 16, 2003 at 08:21:56PM -0800, Chris Wedgwood wrote:
> > On Sun, Feb 16, 2003 at 08:46:05PM -0600, Mark J Roberts wrote:
> > > When the windows box behind my NAT is using all of my 640kbit/sec
> > > downstream to download movies, it takes a little over 14 hours to
> > > download four gigabytes and roll over the byte counter.
> >
> > Therefore userspace needs to check the counters more often... say ever
> > 30s or so and detect rollover.  Most of this could be simply
> > encapsulated in a library and made transparent to the upper layers.
>
>   Some of my colleques complained once, that at full tilt
>   the fiber-channel fabric overflowed its SNMP bitcounters
>   every 2 seconds.
>
>   "we need to do polling more rapidly, than the poller can do"
>
>   The SNMP pollers do handle gracefully 32-bit unsigned overlow,
>   they just need to get snapshots in increments a bit under 2G...
>   (Hmm.. perhaps I remember that wrong, a bit under 4G should be ok.)
>
> >   --cw
>
> /Matti Aarnio
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

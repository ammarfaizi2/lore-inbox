Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbTAICNI>; Wed, 8 Jan 2003 21:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbTAICNH>; Wed, 8 Jan 2003 21:13:07 -0500
Received: from ftp.tpi.com ([198.107.51.136]:13074 "EHLO mailgate.tpi.com")
	by vger.kernel.org with ESMTP id <S261370AbTAICNF> convert rfc822-to-8bit;
	Wed, 8 Jan 2003 21:13:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Gardner <timg@tpi.com>
Reply-To: timg@tpi.com
Organization: TriplePoint, Inc
To: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
Subject: Re: 2.4.19 ICMP redirects erroneously ignored
Date: Wed, 8 Jan 2003 19:21:44 -0700
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301081852.05547.rtg@tim.rtg.net> <1042046214.17783.7.camel@ranjeet-linux-1>
In-Reply-To: <1042046214.17783.7.camel@ranjeet-linux-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301081921.44506.timg@tpi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand the ramifications of ICMP redirect and how it can be mis-used. 
However, the SuSE 8.1 default for non-forwarding 
(/proc/sys/net/ipv4ip_forward==0) Linux is to accept redirects. I also own 
the router, so I trust it.

rtg
On Wednesday 08 January 2003 10:16, Ranjeet Shetye wrote:
> On Thu, 2003-01-09 at 02:52, Tim Gardner wrote:
> > I'm getting pounded by ICMP redirects from my Nortel router. The
> > setup is a SuSE 8.1 (2.4.19) standard client with fixed IP and netmask.
> > The client is configured with a default route. However, there are
> > several routers on the subnet that the default router knows about.
> > Hence, the reason that the Nortel router emits ICMP redirects
> > which my client steadfastly ignores.
> >
> > I've RTFM, read the kernel source, and checked the relevant settings
> > (/proc/sys/net/ipv4/conf/all/*). I find in /proc/net/rt_cache that there
> > are 2 entries, one of which is marked RTCF_REDIRECTED.
> >
> > Why isn't this redirected route being used?
>
> AFAIK, because that would mean that you are allowing another machine to
> manipulate your routing tables by simply using ICMP. How do you know
> that you can trust the other machine, in this case, the nortel router ?
> The problem is not of (missing) functionality, its about trusting the
> integrity of the source of the ICMP redirect.
>
> > This seems like a problem that ought to be common to anyone that
> > has multiple routers on the same subnet. What am I missing?
> >
> > rtg
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Gardner - timg@tpi.com 406-443-5357
TriplePoint, Inc. - http://www.tpi.com
PGP: http://www.tpi.com/PGP/Tim.txt

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTAICHv>; Wed, 8 Jan 2003 21:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTAICHu>; Wed, 8 Jan 2003 21:07:50 -0500
Received: from mail5.intermedia.net ([206.40.48.155]:55057 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id <S261356AbTAICHr>; Wed, 8 Jan 2003 21:07:47 -0500
Subject: Re: 2.4.19 ICMP redirects erroneously ignored
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: timg@tpi.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301081852.05547.rtg@tim.rtg.net>
References: <200301081852.05547.rtg@tim.rtg.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Jan 2003 18:16:54 +0100
Message-Id: <1042046214.17783.7.camel@ranjeet-linux-1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 02:52, Tim Gardner wrote:
> I'm getting pounded by ICMP redirects from my Nortel router. The
> setup is a SuSE 8.1 (2.4.19) standard client with fixed IP and netmask.
> The client is configured with a default route. However, there are
> several routers on the subnet that the default router knows about.
> Hence, the reason that the Nortel router emits ICMP redirects
> which my client steadfastly ignores.
> 
> I've RTFM, read the kernel source, and checked the relevant settings 
> (/proc/sys/net/ipv4/conf/all/*). I find in /proc/net/rt_cache that there are 
> 2 entries, one of which is marked RTCF_REDIRECTED.
> 
> Why isn't this redirected route being used? 

AFAIK, because that would mean that you are allowing another machine to
manipulate your routing tables by simply using ICMP. How do you know
that you can trust the other machine, in this case, the nortel router ?
The problem is not of (missing) functionality, its about trusting the
integrity of the source of the ICMP redirect.

> 
> This seems like a problem that ought to be common to anyone that
> has multiple routers on the same subnet. What am I missing?
> 
> rtg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263263AbVCKK7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbVCKK7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbVCKK7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:59:10 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:31348 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263263AbVCKK7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:59:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AwCh2lHH1jHC2pG41Lu7OtxOIJYfn5yP6+ggJeRVsSUWPHx86dvq4rVTsgN0Q50TYtq55AXk2fzunZW3WQHwKQNEsGpiQDVrX/D0XBpR/UDXYfyFr0scBA1n120Ckg6dimGq7PG09c7L8kEhSonRXssSYKNsaq3k0X7ntqdZxNw=
Message-ID: <2cd57c9005031102595dfe78e6@mail.gmail.com>
Date: Fri, 11 Mar 2005 18:59:03 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Christian Kujau <evil@g-house.de>
Subject: Re: oom with 2.6.11
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <422DC2F1.7020802@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422DC2F1.7020802@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file mm/oom_kill.c, uncomment line 24: /* #define DEBUG */. 
And next time when oom happens again, we'll see the badness.

--coywolf

On Tue, 08 Mar 2005 16:21:21 +0100, Christian Kujau <evil@g-house.de> wrote:
> hallo list,
> 
> today my machine went out out memory and noticing it several hours after
> the first OOM message in the log, i wonder
>    1) why this happened at all and
>    2) why almost every service was killed despite the clever algorithms
>       documented in mm/oom_kill.c.
> 
> the first oom message went to the syslog at 01:27, i was away and no heavy
> tasks were scheduled:
> 
> http://nerdbynature.de/bits/sheep/2.6.11/oom/oom_2.6.11.txt
> 
> mysqld got killed by the oom killer, so i have to suspect mysql for being
> the reason for oom here, even that i know that mysqld is running all day
> long. several other tasks got killed, but "Free swap" stays at 0kB and the
> oom killer kills almost every other tasks, with no success in freeing ram.
> 
> the log stops at 03:21, perhaps syslog-ng got killed.
> at around 07:31 i noticed the mess, did SYSRQ-E and now i was able to
> login again. i pressed SYSRQ-M/T/P too, they are all in the log. at this
> time loadavg was at 249 ;)
> 
> i went to runlevel 2, then up again to 3 and all services are up and
> running again.
> 
> some 2.6.11-rc3 BK snapshot was running pretty stable (no OOM) for ~30
> days before i switched to 2.6.11 (vanilla) a few days ago. i have to (not)
> reproduce the problem the next night, i wonder if it will happen again.
> 
> do you vm-gurus have any idea to the points asked above?
> 
> more infos about the box here: http://nerdbynature.de/bits/sheep/2.6.11/oom/
> 
> thank you for your comments,
> Christian.
> --
> BOFH excuse #281:
> 
> The co-locator cannot verify the frame-relay gateway to the ISDN server.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/

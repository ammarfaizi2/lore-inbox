Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282373AbRK2EMA>; Wed, 28 Nov 2001 23:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282372AbRK2ELl>; Wed, 28 Nov 2001 23:11:41 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:58764 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282371AbRK2ELd>;
	Wed, 28 Nov 2001 23:11:33 -0500
Message-ID: <3C05B561.75F210C7@pobox.com>
Date: Wed, 28 Nov 2001 20:11:13 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-tux2-ll i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: data point: tux and low-latency patches OK
In-Reply-To: <3C043B11.2FA17A19@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to follow up, I compiled 2.4.16 with the
low latency patch from Andrew Morton, as
well as the 2.4.16-disk-i/o-responsiveness
patch from Andrew, and tux-full-2.4.16-A3.

I hammered tux all night with an apachebench
script, and it never hiccupped. So, while tux
and preempt don't play well together, tux and
low-latency seem to get along just fine.

Regards,

jjs


J Sloan wrote:

> I built 2.4.16+low-latency+preempt+tux2, and
> started testing it. To my horror, the webserver
> died - I checked the logs and found an oops -
> (for your edification, I attach it below)
>
> So, I figured, preempt and low latency don't
> mix well - I'll just build a kernel with tux and
> preempt.
>
> To my horror, the new kernel without the
> low latency patch oopsed immediately as
> well, as soon as I started an apachebench
> run from a remote testing box.
>
> (for you edification, I include this oops also)
>
> I removed the preempt patch and basically
> compiled just 2.4.16+tux, and hammered on
> it for several hours - rock solid.
>
> So, there is an issue with tux and the preempt
> patch - I've got big plans for tux atm, so for
> now I will have to do without preempt -
>
> Thanks & Regards,
>
> jjs
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


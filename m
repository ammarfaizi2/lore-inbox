Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbWKHVBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWKHVBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWKHVBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:01:32 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:64152 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932722AbWKHVBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:01:31 -0500
Message-ID: <4552459F.7000709@gmail.com>
Date: Wed, 08 Nov 2006 22:01:19 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] HZ: 300Hz support
References: <1163018557.23956.92.camel@localhost.localdomain>
In-Reply-To: <1163018557.23956.92.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Fix two things. Firstly the unit is "Hz" not "HZ". Secondly it is useful
> to have 300Hz support when doing multimedia work. 250 is fine for us in
> Europe but the US frame rate is 30fps (29.99 blah for pedants). 300
> gives us a tick divisible by both 25 and 30, and for interlace work 50
> and 60. It's also giving similar performance to 250Hz.
> 
> I'd argue we should remove 250 and add 300, but that might be excess
> disruption for now.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.19-rc4-mm1/kernel/Kconfig.hz
> linux-2.6.19-rc4-mm1/kernel/Kconfig.hz
> --- linux.vanilla-2.6.19-rc4-mm1/kernel/Kconfig.hz	2006-10-31
> 15:40:54.000000000 +0000
> +++ linux-2.6.19-rc4-mm1/kernel/Kconfig.hz	2006-11-08 17:06:38.000000000
> +0000
> @@ -7,7 +7,7 @@
>  	default HZ_250
>  	help
>  	 Allows the configuration of the timer frequency. It is customary
> -	 to have the timer interrupt run at 1000 HZ but 100 HZ may be more
> +	 to have the timer interrupt run at 1000 Hz but 100 Hz may be more
>  	 beneficial for servers and NUMA systems that do not need to have
>  	 a fast response for user interaction and that may experience bus
>  	 contention and cacheline bounces as a result of timer interrupts.
> @@ -19,21 +19,30 @@
>  	config HZ_100
>  		bool "100 HZ"
[...]
>  	config HZ_250
>  		bool "250 HZ"
[...]
> +	config HZ_300
> +		bool "300 HZ"
[...]
>  	config HZ_1000
>  		bool "1000 HZ"

Shouldn't be these also changed (I mean those in quotes)?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

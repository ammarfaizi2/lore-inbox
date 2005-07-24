Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVGXEVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVGXEVK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 00:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVGXEVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 00:21:10 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:44954 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261268AbVGXEVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 00:21:09 -0400
Message-ID: <42E31661.4000008@upb.de>
Date: Sun, 24 Jul 2005 06:17:37 +0200
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050428)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [cpufreq] ondemand works, conservative doesn't
References: <dbucpq$7ti$1@sea.gmane.org> <42E30480.40909@linuxwireless.org>
In-Reply-To: <42E30480.40909@linuxwireless.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> currently, i'm using the ondemand governor. My CPU supports the
>> frequencies 800, 1800 and 2000 MHz (AMD Athlon64 Desktop with
>> Cool&Quiet). The simple bash commands
>>
>  
> In my case, I have a Pentium M 1.8ghz 400 FSB. In powersave, it goes to
> 1.19ghz, in conservative, it goes to 1.20GHZ and of course performance
> goes to 1.8ghz if plugged.
> 
> Conservative works well here, and so far, lt moved slowly from
> frequencies, 1.2 then in 5 seconds 1.4, 2 seconds 1.8. Then it took the
> CPU like 10 seconds to move back from 1.8ghz to 1.2..

Yes. Pentium M CPUs offer frequencies is 200MHz steps. And I was pretty
sure, that the conservative govenor works in that case.

> Mine did reach the full cpu in a moment, yours looks like it not going
> over 2.0ghz. Maybe is not needing that much CPU?

Running an "while true; do true; done" will result in process named
"bash" that uses 100% of the cpu. The problem i see is, that the
conservative govenor never considers to switch from 800MHz to 1800MHz
because it's a 1000MHz jump! (i'd consider that as a bug, since the
govenor is non-functional in such an environment)

> If it only supports 800, 1800 and 2000 MHz, then it will only jump to
> those frequencies. I use the CPU Frequency Scaling Monitor included in
> gnome to switch between these options a lot. Maybe you could play with
> this a bit more and see how it behaves. It does look like it might need
> more frequencies, but you would need to check what does you CPU support.

I would be very glad, if the conservative-govenor would switch to the
three frequencies i listet. The problem is: it doesn't.

AFAIK, AMD Desktop CPUs really support 3 frequencies only :-(

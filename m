Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266506AbUBLW6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUBLW6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:58:54 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:57531 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266506AbUBLW6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:58:53 -0500
Message-ID: <402C050B.2040803@cyberone.com.au>
Date: Fri, 13 Feb 2004 09:58:19 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rudo Thomas <rudo@matfyz.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug, or is it? - SCHED_RR and FPU related
References: <20040212205708.GA1679@ss1000.ms.mff.cuni.cz>
In-Reply-To: <20040212205708.GA1679@ss1000.ms.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rudo Thomas wrote:

>Hello.
>
>I have stumbled upon a grave bug, I think. I can reproduce a hard lock-up using
>xmms and a buggy plugin - only SysRq-B helps. I managed to narrow it down to
>"0.5/NAN"-like operation. It only causes a complete hang when xmms is run with
>SCHED_RR priority. Otherwise, only xmms hangs. Unfortunately, I was not able to
>create a working proof-of-concept program.
>
>The question is - is this a kernel bug, OR something that cannot be prevented
>from happening when using SCHED_RR policy?
>
>Tried with 2.6.3-rc[12] and glibc-2.3.2 (-r9 gentoo) with nptl support (if that
>matters).
>
>Have a nice day.
>
>

Hi Rudo,
xmms probably goes into an infinite loop, preventing anything else
from being scheduled, right? If that's the case then this is correct
behaviour.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTIOCI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 22:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTIOCI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 22:08:57 -0400
Received: from dyn-ctb-210-9-246-130.webone.com.au ([210.9.246.130]:35332 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262422AbTIOCIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 22:08:55 -0400
Message-ID: <3F651F23.8040207@cyberone.com.au>
Date: Mon, 15 Sep 2003 12:08:35 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com> <20030912195606.24e73086.ak@suse.de> <bk2um1$flp$1@gatekeeper.tmr.com> <Pine.LNX.4.53.0309142058120.5140@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0309142058120.5140@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Zwane Mwaikambo wrote:

>On Sun, 14 Sep 2003, bill davidsen wrote:
>
>
>>We just got a start on making Linux smaller to encourage embedded use, I
>>don't see adding 300+ bytes of wasted code so people can run
>>misconfigured kernels.
>>
>>I rather have to patch this in for my Athlon kernels than have people
>>who aren't cutting corners trying to avoid building matching kernels
>>have to live with the overhead.
>>
>
>Overhead? Really you could save more memory by cleaning up a lot of 
>drivers. Andi already said it before, there are better places to be 
>looking at.
>
>Also 'patching' for Athlon kernels doesn't cut it for people who need to 
>distribute kernels which run on various hardware (such as distros). This 
>alone is benefit enough to justify this supposed 'bloat'.
>

Hi Zwane,

I still don't mind Adrian's patch (at least the concept). Its true, the
Athlon workaround is insignificant, but Adrian's patch allows the
possibility of compiling things like it out. Its also clearer to me than
the current scheme.

The only objections I have seen are from those who don't understand what
it does or implmentation issues. It might be the case that it can't be
done "nicely" without more support from kconfig and/or kbuild though.



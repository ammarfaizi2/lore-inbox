Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUEXTgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUEXTgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUEXTgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 15:36:18 -0400
Received: from mail.tmr.com ([216.238.38.203]:35077 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264401AbUEXTgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 15:36:11 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: tvtime and the Linux 2.6 scheduler
Date: Mon, 24 May 2004 15:38:45 -0400
Organization: TMR Associates, Inc
Message-ID: <c8tikk$u6f$1@gatekeeper.tmr.com>
References: <20040523154859.GC22399@dumbterm.net> <20040523224908.25194.qmail@web40607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Trace: gatekeeper.tmr.com 1085427156 30927 192.168.12.100 (24 May 2004 19:32:36 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040523224908.25194.qmail@web40607.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

szonyi calin wrote:
>  --- Billy Biggs <vektor@dumbterm.net> a écrit : >   I am the
> author of tvtime, a TV application with advanced
> 
>>image
>>processing algorithms.  Some users are complaining about poor
>>performance under Linux 2.6, and I would like more information
>>about how
>>tvtime will be treated by the scheduler.  Here is an example
>>of the
>>intended usage:
>>
>>  - Program running as root and SCHED_FIFO
>>  - NTSC, input ~30 fps, each field processed for an output of ~60 fps
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^
>>  - CPU intensive processing, say 9 ms per field on my P3-733
>>  - with a typical AGP card, the X driver takes 4 ms to draw
>>  - Wait using /dev/rtc set to 1024 Hz
>>
>>  for(;;)
>>      9 ms : process frame
>>      4 ms : draw frame
>>      3 ms : wait until next field time using /dev/rtc
>>      9 ms : process frame
>>      4 ms : draw frame
>>      3 ms : block on /dev/video0 for next frame
>>     -----
>>     33 ms : time per NTSC frame
	[___snip___]
> For me it works ok
> Running tvtime with 2.6.6-mm5 load average 26 (twenty six) it
> works 
> almost perfect (no frame skipped -- at least not reported by
> tvtime)
> at full rate (50 frames/sec). Computer: AMD Duron 700 MHz, 256MB
~~~~~~~~~~~~~~~~^^^
> Ram,
> VIA KT133 chipset, AGP 4x, Ati Radeon 7200 

There have been pretty good explanations of this, so I'll just say that 
it might be that someone with a machine of limited capacity would be 
able to generate 50fps and not 60fps. In much of Europe the TV flickers 
at the same frequency as the lights ;-)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

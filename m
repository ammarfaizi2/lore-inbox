Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269375AbUHZTIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269375AbUHZTIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269376AbUHZTED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:04:03 -0400
Received: from mail.tmr.com ([216.238.38.203]:15113 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269391AbUHZS7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:59:25 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: bizarre 2.6.8.1 /sys permissions
Date: Thu, 26 Aug 2004 15:00:01 -0400
Organization: TMR Associates, Inc
Message-ID: <cglbia$9o2$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0408251630380.17580-100000@sasami.anime.net><Pine.LNX.4.44.0408251630380.17580-100000@sasami.anime.net> <20040826004857.GA5583@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093546378 9986 192.168.12.100 (26 Aug 2004 18:52:58 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040826004857.GA5583@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Aug 25, 2004 at 04:31:50PM -0700, Dan Hollis wrote:
>  > >  > $ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
>  > >  > cat: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: Permission denied
>  > > Reading this file causes reads from hardware on some cpufreq drivers.
>  > > This can be a slow operation, so a user could degrade system performance
>  > > for everyone else by repeatedly cat'ing it.
>  > 
>  > any reason why cpuinfo_cur_freq cant read cpu_khz ?
> 
> cpufreq_cur_freq will be one of scaling_available_frequencies.
> These are usually a value such as 1300MHz, where cpu_mhz is a
> 'measured' value and will look something like 1303.852
> 
> the values cpufreq uses are the values either returned by the
> hardware as its settable states, or from BIOS tables defining
> those states.
> 
>  > or rather, is there any reason why cpuinfo_cur_freq and /proc/cpuinfo 
>  > should legitimately differ?
> 
> They aren't identical, and serve different purposes.

Okay, so cpufreq just gives informational values in a table while 
/proc/cpuinfo actually reflects the speed of the CPU. Right? That's 
good, I thought there was an problem if they were different.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

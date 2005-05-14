Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVENRFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVENRFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 13:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVENRFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 13:05:37 -0400
Received: from main.gmane.org ([80.91.229.2]:36020 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262803AbVENRF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 13:05:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: Hyper-Threading Vulnerability
Date: Sat, 14 May 2005 19:04:29 +0200
Message-ID: <d65b2m$atq$1@sea.gmane.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>	 <20050513215905.GY5914@waste.org>	 <1116024419.20646.41.camel@localhost.localdomain>	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>	 <1116027488.6380.55.camel@mindpipe>	 <1116084186.20545.47.camel@localhost.localdomain> <1116088229.8880.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 195.70.138.133.adsl.nextra.cz
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
In-Reply-To: <1116088229.8880.7.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2005-05-14 at 16:23 +0100, Alan Cox wrote:
> 
>>On Sad, 2005-05-14 at 00:38, Lee Revell wrote:
>>
>>>Well yes but you would still have to recompile those apps.  And take the
>>>big performance hit from using gettimeofday vs rdtsc.  Disabling HT by
>>>default looks pretty good by comparison.
>>
>>You cannot use rdtsc for anything but rough instruction timing. The
>>timers for different processors run at different speeds on some SMP
>>systems, the timer rates vary as processors change clock rate nowdays.
>>Rdtsc may also jump dramatically on a suspend/resume.
>>
>>If the app uses rdtsc then generally speaking its terminally broken. The
>>only exception is some profiling tools.
> 
> 
> That is basically all JACK and mplayer use it for.  They have RT
> constraints and the tsc is used to know if we got woken up too late and
> should just drop some frames.  The developers are aware of the issues
> with rdtsc and have chosen to use it anyway because these apps need
> every ounce of CPU and cannot tolerate the overhead of gettimeofday(). 

AFAIK, mplayer actually uses gettimeofday(). rdtsc is used in some
places for profiling and debugging purposes and not compiled in by default.

-- 
Jindrich Makovicka


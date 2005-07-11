Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVGKWNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVGKWNS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVGKWNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:13:10 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:43485 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262740AbVGKWDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:17 -0400
Message-ID: <33519.192.168.1.8.1121119251.squirrel@www.rncbc.org>
In-Reply-To: <20050711155503.GA21762@elte.hu>
References: <20050703133738.GB14260@elte.hu>
    <1120428465.21398.2.camel@cmn37.stanford.edu>
    <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>
    <20050707194914.GA1161@elte.hu>
    <49943.192.168.1.5.1120778373.squirrel@www.rncbc.org>
    <57445.195.245.190.94.1120812419.squirrel@www.rncbc.org>
    <20050708085253.GA1177@elte.hu>
    <28798.195.245.190.94.1120815616.squirrel@www.rncbc.org>
    <20050708095600.GA5910@elte.hu>
    <63108.195.245.190.94.1121094757.squirrel@www.rncbc.org>
    <20050711155503.GA21762@elte.hu>
Date: Mon, 11 Jul 2005 23:00:51 +0100 (WEST)
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-11 glitches [no more]
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 11 Jul 2005 22:03:13.0525 (UTC) FILETIME=[55434250:01C58664]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
>
>> After several trials, with CONFIG_PROFILING=y and profile=1
>> nmi_watchdog=2 as boot parameters, I'm almost convinced I'm doing
>> something wrong :)
>>
>> - `readprofile` always just outputs one line:
>>
>>      0 total                                    0.0000
>>
>> - `readprofile -a` gives the whole kernel symbol list, all with zero
>> times.
>>
>> Is there anything else I can check around here?
>
> it means that the NMI watchdog was not activated - i.e. the 'NMI' counts
> in /proc/interrupts do not increase. Do you have LOCAL_APIC enabled in
> the .config? If yes and if nmi_watchdog=1 does not work either then it's
> probably not possible to activate the NMI watchdog on your box. In that
> case try nmi_watchdog=0, that should activate normal profiling. (unless
> i've broken it via the profile-via-NMI changes ...)
>

I've tried whether having nmi_watchdog has any influence, to no
distinguishable result; readprofile always says zero times. And I'm sure I
have LOCAL_APIC=y (see attached config.gz)
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


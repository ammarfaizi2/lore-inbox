Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVHaRZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVHaRZR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVHaRZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:25:17 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:4793 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964892AbVHaRZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:25:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DJ/Havw+xwAgryzwptlcj70A43Jawrhk+rlitVqKFfTmI7jEX3PXhUjpFP5nkSMlW4/jTZscshzRW2uaiFkgwFaSa5nCuaptFv0vtiVvjZArANVLGQwb4aS25mAEgiTrkAmjxavWwSOE9DPoyvWTPBTSsL56NsK8PcwxkrHoRnc=  ;
Message-ID: <4315E810.4030305@yahoo.com.au>
Date: Thu, 01 Sep 2005 03:25:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Holger Kiehl <Holger.Kiehl@dwd.de>
CC: Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de> <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de> <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <4315A179.8070102@yahoo.com.au> <Pine.LNX.4.61.0508311524190.16574@diagnostix.dwd.de>
In-Reply-To: <Pine.LNX.4.61.0508311524190.16574@diagnostix.dwd.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl wrote:

> meminfo.dump:
> 
>    MemTotal:      8124172 kB
>    MemFree:         23564 kB
>    Buffers:       7825944 kB
>    Cached:          19216 kB
>    SwapCached:          0 kB
>    Active:          25708 kB
>    Inactive:      7835548 kB
>    HighTotal:           0 kB
>    HighFree:            0 kB
>    LowTotal:      8124172 kB
>    LowFree:         23564 kB
>    SwapTotal:    15631160 kB
>    SwapFree:     15631160 kB
>    Dirty:         3145604 kB

Hmm OK, dirty memory is pinned pretty much exactly on dirty_ratio
so maybe I've just led you on a goose chase.

You could
     echo 5 > /proc/sys/vm/dirty_background_ratio
     echo 10 > /proc/sys/vm/dirty_ratio

To further reduce dirty memory in the system, however this is
a long shot, so please continue your interaction with the
other people in the thread first.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287681AbSANQoW>; Mon, 14 Jan 2002 11:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287626AbSANQoM>; Mon, 14 Jan 2002 11:44:12 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:59640 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S287657AbSANQn4>;
	Mon, 14 Jan 2002 11:43:56 -0500
Message-ID: <3C430985.3090700@dplanet.ch>
Date: Mon, 14 Jan 2002 17:38:29 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
In-Reply-To: <fa.dardpev.1m1emjp@ifi.uio.no> <3C42AF6B.6050304@debian.org> <20020114111608.B14332@thyrsus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2002 16:40:42.0824 (UTC) FILETIME=[35131C80:01C19D1A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eric S. Raymond wrote:

> Giacomo Catenazzi <cate@debian.org>:
> 
>>>With this change, generating a report on ISA hardware and other
>>>facilities configured in at boot time would be trivial.  This would
>>>make the autoconfigurator much more capable.  Best of all, the only
>>>change required to accomplish this would be safe edits of print format
>>>strings.
>>>
>> 
>>Better: create a /proc/driver and every driver will register in it.
>>This file can help some bug report (and not only autoconfigurator).
>>
> 
> That would be fine with me.  But wouldn't it involve adding a new
> initialization-time call to every driver.


I think we can add it automatically, modifing one of the
the modules macros. (this works automatically only for
trit symbols).
Hmm. IIRC there is a  big module/driver API (for modules) change
in 2.5 programs (driver registration,...). In this case we should
only modify the API before it will be effectivelly used, and
the changes will go automatically in kernel...

	giacomo




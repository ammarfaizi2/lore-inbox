Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290878AbSBRTZK>; Mon, 18 Feb 2002 14:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291081AbSBRTXC>; Mon, 18 Feb 2002 14:23:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62732 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291289AbSBRTWm>; Mon, 18 Feb 2002 14:22:42 -0500
Message-ID: <3C71545E.3070306@zytor.com>
Date: Mon, 18 Feb 2002 11:22:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: linux-kernel@vger.kernel.org, "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Missed jiffies
In-Reply-To: <3C6E77DE.70FE49DF@rwii.com> <3C6E833F.1A888B3C@mvista.com> <a4pbvi$iq2$1@cesium.transmeta.com> <3C715036.EBC74D72@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:

> "H. Peter Anvin" wrote:
> 
>>Followup to:  <3C6E833F.1A888B3C@mvista.com>
>>By author:    george anzinger <george@mvista.com>
>>In newsgroup: linux.dev.kernel
>>
>>>One of the nasty problems, especially with machines such as yours (i.e.
>>>lap tops), is the fact that TSC is NOT clocked at a fixed rate.  It is
>>>affected by throttling (reduced in 12.5% increments) and by power
>>>management.
>>>
>>If the TSC is affected by HLT, throttling, or C2 power management, the
>>TSC is broken (as it is on Cyrix chips, for example.)  The TSC usually
>>*is* affected by C3 power management, but the OS should be aware of
>>C3.
>>
> Gosh I would LIKE to think this is true.  Could you give a reference?  I
> believe Andrew Grover thinks that what I have stated is true.  If I am
> wrong, it will make the high-res-timers MUCH more acceptable as the TSC
> overhead is MUCH lower that the ACPI pm timer.
> 
> Do I have this right Andrew?
> 


What I have defined above is what Linux considers a "working" TSC.  I
belive this to be functional on Intel, AMD and Transmeta CPUs.

However, there are some systems -- especially using older chips with less
PLL delays -- which change CLKIN on the fly.

	-hpa




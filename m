Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281558AbRLDReZ>; Tue, 4 Dec 2001 12:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283271AbRLDRc7>; Tue, 4 Dec 2001 12:32:59 -0500
Received: from c007-h012.c007.snv.cp.net ([209.228.33.219]:61434 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S281558AbRLDRbk>;
	Tue, 4 Dec 2001 12:31:40 -0500
X-Sent: 4 Dec 2001 17:31:33 GMT
Message-ID: <3C0D0850.1F156158@bigfoot.com>
Date: Tue, 04 Dec 2001 09:30:56 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Cheryl Homiak <chomiak@chartermi.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via82cxx chipset problem
In-Reply-To: <Pine.LNX.4.40.0112030943110.223-100000@maranatha.chartermi.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cheryl Homiak wrote:
> 
> I tried this question on another list and was told not to try to change my
> mhz speed because I would corrupt my hard drive possibly. But does this
> mean I am actually running at only 33mhz.? This doesn't seem like a viable
> way to run my computer and I am having problems with installing new memory
> that may be related to this. My original message is below; any help would
> be appreciated.
> Thanks.

Most modern motherboards use a 1/2, 1/3 or 1/4 divider on the memory bus
(set in BIOS) to get PCI values.  idebus= is used for anything other
than 33MHz:

Mem	PCI	divider	idebus=
66	33	1/2	default
75	37.5	1/2	38
85	42.5	1/2	43
100	33	1/3	default
133	33	1/4	default

For example, setting the bus at 75MHz would mean 'idebus=38' on the boot
command line or in lilo to prevent timing problems which could lead to
disk data corruption.  Most PCI bus related data corruption occured when
driving the bus more than 15% over spec.

rgds,
tim.
--

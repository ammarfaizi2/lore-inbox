Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUBODla (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 22:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUBODl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 22:41:29 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:28879
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S263880AbUBODlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 22:41:25 -0500
Message-ID: <402EE603.8020106@tmr.com>
Date: Sat, 14 Feb 2004 22:22:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Simitzis <steve@saturn5.com>
CC: "Feldman, Scott" <scott.feldman@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: e1000 problems in 2.6.x
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229F6F@orsmsx402.jf.intel.com> <20040215023226.GE1040@saturn5.com>
In-Reply-To: <20040215023226.GE1040@saturn5.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Simitzis wrote:
> i should have mentioned in my email that i tried every combination of
> settings: auto-neg on the box and forced on the switch, both forced
> (to the same settings, of course), forced on the box with auto-neg on
> the switch, and auto-neg on both sides. in all cases, the result was
> the same: RX packet errors and the same watchdog messages. what i thought
> was particularly strange was that the switch refused to auto-negotiate
> full duplex.
> 
> (someone on another list suggested to try booting with the noapic
> option, which i tried for good measure, even though i don't see
> how that could have helped. again, no improvement.)
> 
> i was initially tempted to assume they were hardware problems, until
> i noticed that the problems only appeared when running a 2.6 kernel.
> also, the machines are only a few months old, so i'm assuming that
> all the hardware is modern enough to do the right thing.
> 
> if there's anything you'd recommend trying out, please let me know.
> i considered trying to run the 2.4.22 driver in a 2.6 installation,
> but i didn't know if any of the driver code depended on anything else
> elsewhere in the kernel source.
> 
> On 02/14/04, "Feldman, Scott" <scott.feldman@intel.com> wrote: 
> 
> 
>>>another oddity is that even after forcing my interfaces to 
>>>100 Mbps full duplex, my switch is reporting half duplex. 
>>>again, this only happens in 2.6.x. when running 2.4.22, full 
>>>duplex is properly negotiated between the e1000 and my switch.
>>
>>Are you forcing both the e1000 interfaces and the switch ports to the
>>same forced settings?  A duplex mismatch would cause problems, but I'm
>>not sure why this is happening for 2.6 only.  What happens if you don't
>>force settings, and just rely on autoneg?  (Again, on both ends of the
>>wire).

1 - check your cables in case 2.6 is checking (or not) something
2 - set your NIC half to match the switch and see if there's a different 
problem.

Switches and NICs, especially nice new ones, don't always or even 
usually auto-auto, at least with any of the stuff I have. I have one 
system which works well full when the switch negotiates full and the NIC 
gets half. Any other force usually works poorly. If the NIC comes up 
helf just kick it into full in rc.local (ethtool, mii-tool, whatever) as 
long as the switch convinces itself that it's full.

I see this with 2.4 as well, so I'm familiar if not expert.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979

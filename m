Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266100AbUALSn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 13:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266251AbUALSn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 13:43:29 -0500
Received: from cpc3-hitc2-5-0-cust116.lutn.cable.ntl.com ([81.99.82.116]:53447
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S266100AbUALSmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 13:42:50 -0500
Message-ID: <4002F0C3.6050207@reactivated.net>
Date: Mon, 12 Jan 2004 19:08:51 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Allen <the3dfxdude@hotmail.com>
Cc: ross@datscreative.com.au, linux-kernel@vger.kernel.org
Subject: Re: NForce2, Ross Dickson's timer patch on 2.6.1
References: <20040112173554.GA792@tesore.local>
In-Reply-To: <20040112173554.GA792@tesore.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can confirm this activity, my clock has been skewing recently, but I had not 
made the link myself that this started happening after I started using the 
APIC/IOAPIC nforce fixes.

If theres any debug info I can provide let me know. I run an AMD XP2600+ on an 
Abit NF7-S V2.0 motherboard.

Daniel

Jesse Allen wrote:
> Hi Ross,
> 
> I have a version of your timer patch (io_apic.c) for kernel 2.6.1.  It is 
> attached.  I have been monitoring a problem with it.  It seems that with the 
> patch, I gain 1 seconds time over 10 minutes (roughly).  So I gain about 2-3 
> mintues a day.  I haven't taken exact measurements, but I know it ends up about 
> 20 minutes difference after a week.  This is not good, which would require 
> resetting the time often.  
> 
> I tried the 2.6.1 kernel without the timer patch.  The timer is now back in PIC 
> mode, and interrupt 7 has the old noise.  Synched the time with my watch.  At 
> first, I noticed no gain in time over 10 minutes.  However the next day, I found
> it gained 1-2 seconds.  Now it is about 7 seconds ahead a few days later now.  
> This is much better.
> 
> So I'm left to thinking, the patch does two things, maybe one thing right, and 
> one possibly very wrong:
> 
> 1) It does place the timer in APIC mode.
> 2) But the timer seems to be fed extra interrupts, maybe the same that is found 
> on irq 7 without the patch (is this possible?)
> 
> I remember someone making a comment which might explain the issue:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107098440019588&w=2
> 
> I don't think the patch was much different now than it was then.  So I think 
> there is something wrong with setting up the timer this way.  I don't know if 
> you worked something out with Maciej.  I don't know much about interrupt 
> controller programming so...  if maybe you can explain to me anything I'm
> missing.  For now I've dropped the patch.
> 
> 
> Jesse
> 
> 
> PS:  I have run with disconnect on, and without your ack patch since I got that 
> surpise BIOS update.  No lockups have occurred in the past month, since that.  So the disconnect problem is a BIOS bug.  (Shuttle has not responded)
> 
> PSS:  CC me, I'm not subscribed right now.

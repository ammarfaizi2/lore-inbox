Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280821AbRK0Bwi>; Mon, 26 Nov 2001 20:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281007AbRK0Bw2>; Mon, 26 Nov 2001 20:52:28 -0500
Received: from vp226158.uac62.hknet.com ([202.71.226.158]:54030 "EHLO
	main.coppice.org") by vger.kernel.org with ESMTP id <S280821AbRK0BwQ>;
	Mon, 26 Nov 2001 20:52:16 -0500
Message-ID: <3C02F2EC.7010809@coppice.org>
Date: Tue, 27 Nov 2001 09:57:00 +0800
From: Steve Underwood <steveu@coppice.org>
Organization: Me? Organised?
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en, zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011124103642.A32278@vega.ipal.net> <20011124184119.C12133@emma1.emma.line.org> <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de> <4.3.2.7.2.20011124150445.00bd4240@10.1.1.42> <3C002D41.9030708@zytor.com> <0f050uosh4lak5fl1r07bs3t1ecdonc4c0@4ax.com> <002f01c176d4$f79a3f70$0201a8c0@HOMER> <p05100301b82887aff497@[207.213.214.37]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:

> At 12:49 AM +0100 11/27/01, Martin Eriksson wrote:
> 
>> I sure think the drives could afford the teeny-weeny cost of a power 
>> failure
>> detection unit, that when a power loss/sway is detected, halts all
>> operations to the platters except for the writing of the current sector.
> 
> 
> That's hard to do. You really need to do the power-fail detection on the 
> AC line, or have some sort of energy storage and a dc-dc converter, 
> which is expensive. If you simply detect a drop in dc power, there 
> simply isn't enough margin to reliably write a block.
> 
> Years (many years) back, Diablo had a short-lived model (400, IIRC) that 
> had an interesting twist on this. On a power failure, the spinning disk 
> (this was in the days of 14" platters, so plenty of energy) drove the 
> spindle motor as a generator, providing power to the drive electronics 
> for several seconds before it spun down to below operating speed.
> 
> Of course, that was in the days of thousands of dollars for maybe 20MB 
> of storage....

Quite true. The drives really need to get an "oh heck, the power's about 
to die. Quick, tidy up" signal from the outside world (like down the 
ribbon). Cheap, at the limit, PSUs probably couldn't give enough notice 
to be very helpful. Server grade ones should - they can usually ride 
over brief hiccups in the power, so they should be able to give a few 
10s of ms notice before the regulated power lines start to droop. 
Perhaps the ATA command set should include such a feature, so the OS 
could take instruction from the hardware on the power situation, and 
tell the drives what to do.

Regards,
Steve



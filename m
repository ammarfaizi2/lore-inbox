Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbUAIXah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUAIXah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:30:37 -0500
Received: from pop.gmx.net ([213.165.64.20]:14538 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264342AbUAIXae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:30:34 -0500
X-Authenticated: #4512188
Message-ID: <3FFF3998.9010209@gmx.de>
Date: Sat, 10 Jan 2004 00:30:32 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric <eric@cisu.net>
CC: lkml@nitwit.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6: The hardware reports a non fatal, correctable incident occured
 on CPU 0.
References: <200401091748.10859.lkml@nitwit.de> <200401091712.02802.eric@cisu.net>
In-Reply-To: <200401091712.02802.eric@cisu.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> On Friday 09 January 2004 10:48 am, lkml@nitwit.de wrote:
> 
>>Hi!
>>
>>I did have some very scary issues today playing with 2.6. The system was
>>booted and ran several times today, the longtest uptime was approximately
>>about an hour.
>>
>>But then shortly after having booted 2.6 I got syslog messages:
>>
>>The hardware reports a non fatal, correctable incident occured on CPU 0.
>>
>>I shut down the machine. After this my Athlon XP 2200+ showed up as 1050MHz
>>in BIOS an indeed the bus frequency was set to 100 instead of 133 MHz (how
>>can an OS change the BIOS?!) - nevertheless the CPU should have shown up as
>>1500MHz. I set it back to 133 MHz - which resulted in the machine did not
>>even reach the BIOS no more but was rebooting automatically prior to it. I
>>turned off the machine for some seconds - no change. I turned it off for a
>>few minutes and the BIOS showed up again - with 1050MHz. So I had to set
>>the freq back to 133 MHz a second time. I booted my 2.4.21 kernel which
>>seems to run.
> 
> 	Check your hardware CPU/MOBO/RAM. Overheating? Bad Ram? Cheap mobo?
> MCE should not be triggered under any circumstances unless it is a kernel 
> bug(RARE, I believe the MCE code is simple) or you REALLY have a hardware 
> problem. As said before, the bios is resetting your fsb to 100 as a fail-safe 
> because something bad happened.
> 	BTW, check your setup, an AMD 2200+ should run at 1.8ghz i believe. If you 
> are setting your FSB or multiplier too low, that might also be triggering a 
> problem. A quick google lists amd xp2200+ as 1800mhz

Yes, I would also say that. With my Athlon XP 1700+ (1.466 GHZ, FSB 
133MHZ) clocked at 2.2GHz (FSB200) I get MCE errors, but at 2.1GHz not, 
  even though I can't find stability issues at 2.2GHz. Nevertheless I 
run the system at 2.1GHz.

Prakash

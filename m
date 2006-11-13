Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753869AbWKMEeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbWKMEeq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 23:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbWKMEep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 23:34:45 -0500
Received: from smtpout.mac.com ([17.250.248.178]:6350 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1753869AbWKMEep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 23:34:45 -0500
In-Reply-To: <r6mz6znwbu.fsf@skye.ra.phy.cam.ac.uk>
References: <20061108175412.3c2be30c.holzheu@de.ibm.com> <20061109231533.GE2616@elf.ucw.cz> <20061109231533.GE2616@elf.ucw.cz> <6F3F24CD-2893-43E2-A006-F809E35607AE@mac.com> <r6mz6znwbu.fsf@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0DFC5218-DA70-42BA-9CCA-C9CA761F8B72@mac.com>
Cc: Pavel Machek <pavel@ucw.cz>, Michael Holzheu <holzheu@de.ibm.com>,
       Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: How to document dimension units for virtual files?
Date: Sun, 12 Nov 2006 23:33:52 -0500
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2006, at 10:41:09, Sanjoy Mahajan wrote:
>> Watts are an indication of power emitted or consumed per unit time  
>> (as opposed to current/amperage which counts only the number of  
>> electrons and not the change in energy), so perhaps  
>> "power_flow:mW" or "power_consumption:mW" would make more sense?
>
> So all of the following make sense:
>
> * "Power:mW"
> * "energy flow: mW" (more verbose but equivalent)
> * "energy flow: mJ/s" (even more verbose but also equivalent)

In this case the name is a sysfs file to indicate the load on the  
battery; so spaces are frowned upon and "load:mW" would probably work  
the best.

>> I can conceivably see a need for a "current:mJ_per_s" versus  
>> "current:mW" depending on the hardware-reported units, but never  
>> both at the same time.
>
> I got lost here.  mJ/s is the same as mW, so with either current:mW  
> or current:mJ/s you're back in the soup of measuring current using  
> units of power

Whoops; sorry, I was writing this too early in the morning without my  
caffeine and got myself turned around.  What I _meant_ to say was this:

"I conceivably see a need for a "load:mC_s" versus "load:mW",  
depending on the hardware-reported units, but never both at the same  
time."

Essentially if the hardware reports units of milli-watts or milli- 
Calories-per-second or whatever, then we should report that directly  
and let userspace convert as appropriate; keeping the floating-point  
out of the kernel.

Cheers,
Kyle Moffett


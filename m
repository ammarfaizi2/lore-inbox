Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272632AbTG3Bi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272640AbTG3Bi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:38:27 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:1966
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S272632AbTG3Bi0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:38:26 -0400
Date: Tue, 29 Jul 2003 21:38:25 -0400
Subject: Re: [REPOST] "apm: suspend: Unable to enter requested state" after 2.5.31 (incl. 2.6.0testX)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Charles Lepple <clepple@ghz.cc>
In-Reply-To: <20030730110548.73919ca0.sfr@canb.auug.org.au>
Message-Id: <82E003DC-C22E-11D7-BB43-003065DC6B50@ghz.cc>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 29, 2003, at 09:05  PM, Stephen Rothwell wrote:

> I may have missed this, but do you have the APIC or IO-APIC enabled?

Not sure that I have one on this system... it's pre-i686 (Pentium MMX).

I left the laptop at work, so I don't have dmesg output nearby.

> The patch in question merely moved where the 0x40 descriptor was 
> installed
> in the descriptor table.

You mean it appears at a different table index? For some reason, I 
thought that was a different patch (but I can't seem to find anything 
else from that time period).

[snip]
> The base and limit parts of the descriptor get initialised at run time 
> by
> the code:
>
> 	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
> 	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
>
> These could be set statically, but it was easier to use the availble
> macros.

Do you think it's worth checking the initialized value of the 
bad_bios_desc fields in a 2.5 kernel with working APM? Or do you have 
any other ideas on where to look?

thanks for taking the time to explain this,

-- 
Charles Lepple <ghz.cc!clepple>
http://www.ghz.cc/charles/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVBJUra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVBJUra (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVBJUr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:47:29 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:51621 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S261886AbVBJUq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:46:56 -0500
Message-ID: <420BC814.4050102@scitechsoft.com>
Date: Thu, 10 Feb 2005 12:46:12 -0800
From: Kendall Bennett <kendallb@scitechsoft.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Matthew Garrett <mjg59@srcf.ucam.org>,
       =?ISO-8859-1?Q?Ville_Syrj=E4?= =?ISO-8859-1?Q?l=E4?= 
	<syrjala@sci.fi>,
       Bill Davidsen <davidsen@tmr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <1107695583.14847.167.camel@localhost.localdomain>	 <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi>	 <1108066096.4085.69.camel@tyrosine>	 <9e473391050210121756874a84@mail.gmail.com>	 <1108067388.4085.74.camel@tyrosine> <9e47339105021012341c94c441@mail.gmail.com>
In-Reply-To: <9e47339105021012341c94c441@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

I have missed all the original emails in this thread. I was trying to 
re-subscribe to the lkml a few days ago (I just switched over to 
Thunderbird) but I haven't been getting any traffic. So I will try again.

The one thing I can say is that having worked extensively with ATI 
cards, there are some registers that have an effect on whether the BIOS 
image shows up on at the ROM BAR address or not. To get all the ATI 
cards we have working, we have had to massage some of those registers 
because after the POST has been run, they will cause the BIOS image to 
disappear (not intentionally on ATI's part, but a side effect I think).

Note that the cards that require this work just fine if they are in a 
cold boot state when you run the POST - they only have issues after the 
POST code has been run (which actually affects X drivers trying to read 
the BIOS PLL information too).

So perhaps this problem is something similar?

Regards,

Jon Smirl said the following on 2/10/2005 12:34 PM:
> I added Kendall from Scitech to the CC list. He is the expert on
> getting VBIOS's to post. Maybe he can help.
> 
> On Thu, 10 Feb 2005 20:29:47 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
>>On Thu, 2005-02-10 at 15:17 -0500, Jon Smirl wrote:
>>
>>>On Thu, 10 Feb 2005 20:08:15 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>>>
>>>>It also explicitly states that Windows 2000 and XP don't support this,
>>>>which leads me to suspect that vendors no longer expect POSTing to be
>>>>possible after initial system boot.
>>>
>>>No, it means that some of my ATI cards don't function as secondary
>>>adapters on 2K and XP.
>>
>>And nor will any other card that requires POSTing (assuming that it
>>isn't just ATI being less than honest about driver shortcomings). And
>>we've certainly seen in the past that removing support for functionality
>>in Windows tends to result in hardware no longer supporting that
>>functionality.
>>
>>I have real, shipping hardware here that fails if you simply try to
>>execute the video BIOS POST code. If you think this is due to a
>>shortcoming in existing BIOS emulations, I'm more than happy to dump the
>>video and system BIOS regions and send them to you.
>>
>>--
>>Matthew Garrett | mjg59@srcf.ucam.org
>>
>>
> 
> 
> 

-- 
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


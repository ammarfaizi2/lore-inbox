Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422941AbWJFUiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422941AbWJFUiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422939AbWJFUiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:38:52 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:57099 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1422941AbWJFUiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:38:51 -0400
Message-ID: <4526BB99.2010700@tuxrocks.com>
Date: Fri, 06 Oct 2006 15:24:57 -0500
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: David Gerber <dg-lkml@zapek.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Keyboard Stuttering
References: <200610061218.36883.dg-lkml@zapek.com>
In-Reply-To: <200610061218.36883.dg-lkml@zapek.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gerber wrote:
>> I'm experiencing some severe keyboard stuttering on my laptop.  The 
>> problem is particularly bad in X, and I believe it also occurs at the 
>> console, though I'm having a difficult time verifying that.  The problem 
>> shows up as repeated characters (not regular key-repeat-related), and 
>> sometimes dropped key presses.
> 
> (I'm not subscribed to the list, CC: to me if needed)
> 
> Same problem here. Intel Core 2 Duo with 2.6.19-rc1 x86_64 SMP. Happens on 
> 2.6.17 too. I use 'noapic' as a workaround but that disables one of the CPU 
> core of course.
> 
> I cannot reproduce the problem within the console nor gdm. Only on the X 
> desktop.
> 
> dmesg and dmidecode outputs are available at:
> http://zapek.com/misc/9400_dmesg
> http://zapek.com/misc/9400_dmidecode
> This is a Dell Inspiron 9400.
> 

The Dell Inspiron 9400 and Inspiron E1705 are pretty much the same 
laptop.  I'm glad to hear it's not just my keyboard or anything like that.

It sounds like there are several others who are experiencing the same or 
related issues.

Is there a way to change the interrupt trigger for the keyboard (the 
other devices seem to work just fine)?  Is there a way to force i8042 to 
XT-PIC on interrupt 1, to see whether it's related to the interrupt 
trigger, or something else that just looks similar?  Any other ideas for 
debugging or fixing?

I'd really love not to have to do the noapic or nolapic workaround...

Frank


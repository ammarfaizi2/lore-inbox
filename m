Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVKXPL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVKXPL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVKXPL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:11:56 -0500
Received: from goliath.cnchost.com ([207.155.252.47]:7358 "EHLO
	goliath.cnchost.com") by vger.kernel.org with ESMTP
	id S1751312AbVKXPLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:11:55 -0500
Message-ID: <4385D839.7000005@rickniles.com>
Date: Thu, 24 Nov 2005 10:11:53 -0500
From: Rick Niles <niles@rickniles.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Sub jiffy delay?
References: <200511232039.PAA03184@bellona.cnchost.com> <Pine.LNX.4.61.0511231646100.20759@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511231646100.20759@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I think the best answer for a distribution kernel without making a 
any patches or rebuilding anything is to use the "register_rtc()" hook 
in the rtc driver.   I tried it and it works really well.  This way my 
device driver can drop into a Fedora system without the user having to 
rebuild anything  (other than my driver).

 If I want to get fancy I could check to see if IRQ 8 is taken and use 
it directly if it's not, i.e. the RTC driver isn't loaded. If IRQ 8 is 
taken, check for the RTC driver and then use that via register_rtc().  
In the unlikely event that IRQ 8 is taken and it's not by the RTC 
driver, then I guess the user's out of luck.

Thanks for all the suggestions, they've all been good, but I'm trying 
avoid steep requirements on usage of this driver. 

Rick Niles.


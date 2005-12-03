Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVLCVKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVLCVKd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVLCVKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:10:33 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:62016 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750918AbVLCVKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:10:32 -0500
Message-ID: <439209C6.9080004@m1k.net>
Date: Sat, 03 Dec 2005 16:10:30 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: CX8800 driver and 2.6.15-RC2
References: <20051202201408.GA11046@mail.muni.cz> <4390B0A7.8060306@m1k.net> <20051203180740.GA11293@mail.muni.cz>
In-Reply-To: <20051203180740.GA11293@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:

>On Fri, Dec 02, 2005 at 03:37:59PM -0500, Michael Krufky wrote:
>  
>
>>It was a memory management bug.... Already fixed in -rc3 (where new bugs 
>>were introduced) ...
>>
>>-rc4 isn't bad, but a whole slew of v4l / dvb bugfixes went in JUST 
>>after -rc4 release...
>>
>>Can you try 2.6.15-rc4-git1 and let us know how things are?
>>    
>>
>well, with 2.6.15-rc4-git video_buf related problems are gone, but it's still
>far from usable. xawtv is unable to use tunner.
>
Which card do you have?  What card # does it report in dmesg?  What 
tuner # is it using?  What is the PCI Subsystem id?

The following MIGHT fix it.... If so, I'll need the answers to the four 
questions above, in order to make this behavior occur by default:

modprobe  tda9887

This fixes the problem for analog video with pcHDTV 3000 and DViCO 
FusionHDTV3 Gold-T.  We've already fixed it in cvs so that this will be 
detected by default, if you have a different card, we might have to 
apply a similar fix.  If that doesn't help, then it's a different bug.

>Moreover, it seems that it cannot get another capture format than 320x240 RGB.
>
-- 
Michael Krufky



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVJRDHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVJRDHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 23:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVJRDHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 23:07:13 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:23118 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932399AbVJRDHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 23:07:11 -0400
Message-ID: <435466E4.5020807@linuxtv.org>
Date: Mon, 17 Oct 2005 23:07:16 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cyber Dog <cyberdog3k@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why is DVB stuff compiling?
References: <cbb8f04c0510171929j3378220cp48831caa1b8d478@mail.gmail.com> <435465AC.3070506@linuxtv.org>
In-Reply-To: <435465AC.3070506@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky wrote:

> Cyber Dog wrote:
>
>> #
>> # Multimedia devices
>> #
>> # CONFIG_VIDEO_DEV is not set
>>
>> #
>> # Digital Video Broadcasting Devices
>> #
>> # CONFIG_DVB is not set
>>
>> Which is what I would expect.  So why are these things compiling into
>> the kernel even if they're not selected? Or am I missing something
>> about the process?  Kernel 2.6.13.3 here.  Thanks.
>
> If you go look, you will notice that all of those built-in.o are zero 
> bytes large.  We've already fixed this in kernel 2.6.14 by preventing 
> the build of these empty units with the following patch (you can 
> safely apply it to 2.6.13.y):


I forgot to mention... You CAN apply the patch in my previous message if 
it bothers you enough, but it won't have any real affect on your kernel, 
as those built-in.o are all empty anyway.

>
> Don't build empty built-in.o when DVB/V4L is not configured.
> Thanks to Sam Ravnborg and Keith Owens.
>
> Signed-off-by: Johannes Stezenbach <js@linuxtv.org 
> <mailto:js@linuxtv.org>>

...and I hate it when Thunderbird does stuff like this when I cut&paste 
email addresses :-(

-- 
Michael Krufky


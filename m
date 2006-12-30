Return-Path: <linux-kernel-owner+w=401wt.eu-S1030362AbWL3WpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWL3WpI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 17:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWL3WpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 17:45:08 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:60464 "EHLO
	mtiwmhc12.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030359AbWL3WpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 17:45:06 -0500
Message-ID: <4596EC01.3060508@lwfinger.net>
Date: Sat, 30 Dec 2006 16:45:21 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Aaron Sethman <androsyn@ratbox.org>, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com, netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [OOPS] bcm43xx oops on 2.6.20-rc1 on x86_64
References: <Pine.LNX.4.64.0612171510030.17532@squeaker.ratbox.org> <20061230192104.GB20714@stusta.de> <4596D8DE.2030408@lwfinger.net> <20061230213245.GD20714@stusta.de>
In-Reply-To: <20061230213245.GD20714@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Dec 30, 2006 at 03:23:42PM -0600, Larry Finger wrote:
>> Adrian Bunk wrote:
>>> On Sun, Dec 17, 2006 at 03:15:28PM -0500, Aaron Sethman wrote:
>>>> Just was loading the bcm43xx module and got the following oops. Note that 
>>>> this card is one of the newer PCI-E cards.  If any other info is needed 
>>>> let me know.
>>> Is this issue still present in 2.6.10-rc2-git1?
>>>
>>> If yes, was 2.6.19 working fine?
>> ...
>>
>> Any oops involving wireless extensions is due to 2.6.20-rc1 and -rc2 not having the fix for softmac
>> that is necessitated by the 2.6.20 changes in the work structure.
> 
> "Any oops" are very strong words.

Yes - but I have seen at least 7 or 8 different occurrences of that bug since the patch was first
made available on Dec. 10, and I have seen no bcm43xx oopses from any other cause.

> It wouldn't be the first time that we have several similar bug reports, 
> and it turns out that one is for a completely different issue...
> 
> That's why I asked for testing with 2.6.20-rc2-git1 that includes the 
> two ieee80211softmac patches.

I have been chasing a sound-card issue today and missed that -git1 was out. That version fixes the
two outstanding 2.6.20 softmac issues.

Larry

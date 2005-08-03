Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVHCPbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVHCPbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 11:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVHCPbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 11:31:25 -0400
Received: from [217.16.192.235] ([217.16.192.235]:31210 "EHLO
	mailgwy.ecovision.se") by vger.kernel.org with ESMTP
	id S261950AbVHCPbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 11:31:24 -0400
Message-ID: <42F0E347.2000406@ecovision.se>
Date: Wed, 03 Aug 2005 17:31:19 +0200
From: Henrik Holst <henrik.holst@ecovision.se>
Organization: Ecovision AB
User-Agent: Mozilla Thunderbird 1.0.5 (Windows/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, cipicip@yahoo.com
Subject: Re: kernel 2.6 speed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In windows were performed about 300 millions cycles,
>> while in Linux about 10 millions. This test was run on
>> Fedora 4 and Suse 9.2 as Linux machines, and Windows
>> XP Pro with VS .Net 2003 on the MS side. My CPU is a
>> P4 @3GHz HT 800MHz bus.

> Hi,

> This test gives you the price of the time function on each OS
> since the 4 arithmetical operations are shorter to compute
> (several cycles against tons of cycles). It appears that the time
> function costs about 3 us on Linux against 0.1 us on Windows.

I know that this benchmark is totally flawed, but I couldn't refuse to 
run it on my own and
to my surprise my numbers where the reverse! Running 2.6.12 gave my 
roughly 73 million
"cycles" while WinXP only gave me 28 million "cycles".

This result made me further test the difference in time() in Linux and 
WinXP and on my hw
(Compaq Evo N800c Laptop) it turns out that the time() call takes 
roughly 0.4 us in Linux vs
1.0 us in WinXP.

Using the GetSystemTime() functions in WinXP yielded the same values as 
time() did in Linux,
so it seams like that atleast on my hw that the time() and 
gettimeofday() functions are as fast
or faster than in WinXP. The question is of course why my results differ 
so much from Ciprians.

/Henrik H

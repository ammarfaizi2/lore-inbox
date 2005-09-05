Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVIEOPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVIEOPN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVIEOPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:15:11 -0400
Received: from main.gmane.org ([80.91.229.2]:10896 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751276AbVIEOPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:15:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: 2.6.13 (was 2.6.11.11) and rsync oops (SATA or NFS related?)
Date: Mon, 05 Sep 2005 23:12:15 +0900
Message-ID: <dfhjp3$fd4$1@sea.gmane.org>
References: <dfg2sa$peu$2@sea.gmane.org> <dfguoq$eng$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
In-Reply-To: <dfguoq$eng$1@sea.gmane.org>
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> Kalin KOZHUHAROV wrote:
> 
>> Hi, there.
>> Long time no posting - didn't have kernel problems for long time :-)
>>
>> That is why I am still running 2.6.11.11 (2.6.12 elsewhere). Will move
>> to 2.6.13 soon.
>>
>> Yesterday just bought a new SATAII drive (Seagate Barracuda 7200.8
>> ST3300831AS) and while trying to rsync some data from the old drives the
>> rsync process died with segfault. My SiI3112 controller is not SATAII,
>> but it should work in SATA mode, have another drive for year+. Looking
>> at the dmesg I saw 3 oopses (see the shortened .dmesg file). Run the
>> ksymoops and got some output (see .ksymoops.bz2).
>>
>> Although it does not seem very related to the drive, that is the only
>> recent change in hardware, in software: udev . The machine (MB: A7V8X
>> Deluxe) was working stable for 6 months with a few restarts.
>>
>> As far as reproducibility goes, apart from those 3 oopses everything is
>> OK, didn't even have to restart and am now continuing to rsync some
>> 200GB more.
>>
>> Any ideas as to what caused this?
> 
> 
> OK, I upgraded to the latest 2.6.13 kernel and still got (similar?) oops.
> 
> Looking again at it it might be NFS (using v4 recently) related.

After stopping nfs (both v3 and v4) and rebooting, I could finish the 
required 170GB rsync without more oopses. But I am still not convinced 
whether this is a nfs issue or just I am being lucky this time. Will 
keep on eye on the machine and report here again.

Kalin.

/ When nobody answers, try answering yourself :-| /

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|


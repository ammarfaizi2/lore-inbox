Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWAVSok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWAVSok (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 13:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWAVSok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 13:44:40 -0500
Received: from outbound04.telus.net ([199.185.220.223]:417 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S1750959AbWAVSoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 13:44:39 -0500
Message-ID: <43D3D455.3000808@telusplanet.net>
Date: Sun, 22 Jan 2006 11:52:05 -0700
From: Bob Gill <gillb4@telusplanet.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Krufky <mkrufky@linuxtv.org>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linux kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BTTV broken on recent kernels
References: <43CAFF82.4030500@telusplanet.net> <200601160418.44549.s0348365@sms.ed.ac.uk> <43CC51FE.7090907@telusplanet.net> <43D1DA98.1080704@linuxtv.org>
In-Reply-To: <43D1DA98.1080704@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky wrote:

>
>> Alistair, Lee: thank you for your replies.  Sadly the bug is in the 
>> Nvidia binary.  Changing the driver to nv from nvidia did resolve the 
>> issue.  Now I have to decide whether I like accelerated 3d more, or 
>> using the tv tuner more (till Nvidia fixes the driver).  Thank you 
>> for your time.  I won't waste any more LKML bandwidth on this (Nvidia 
>> bug).  Thanks again.
>> Bob 
>
>
> Not that I would recommend the binary nvidia driver, but:
>
> You can probably get bttv to work despite this overlay bug by using 
> "grabdisplay" mode instead.  There is an option for it in xawtv.  The 
> difference is, in overlay mode, the capture card is writing directly 
> to videoram.  Using grabdisplay mode eliminates this optimization, and 
> would be a decent workaround for you.
>
> Hope this helps,
>
> Michael
>
I haven't tried using nv with grabdisplay instead of overlay, but I have 
recently run a large (nvidia...and no, I don't work for them) patch 
against the 81.78 driver (about 5 small patches all in one) and it works 
successfully on 2.6.16-rc1-git3 (in both grabdisplay and overlay 
modes).  The only thing I noted is that the old nvidia binaries wanted a 
channel frequency offset of 108, but with the (heavily patched) 81.78 
driver, you don't need an channel frequency offset (both xawtv and 
mplayer).  Your test is simple to try though, and if it doesn't work, 
I'll reply and mention it.   Thanks for your reply.
Bob

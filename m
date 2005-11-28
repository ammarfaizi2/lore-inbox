Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVK1OBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVK1OBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 09:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVK1OBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 09:01:36 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:52625 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751262AbVK1OBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 09:01:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VvGnSq2qEIw0bYEJDSNJIw18k53YBCcMJJMZdXPDiaWmJDuiVcIk3qo1XmevzN93j6+hPF7DM8UrQzKFafiOoq94UL7mZUs+nYVM4gv3NZSxNdEFNjujrmGFrvWCb+7K7ultQniupRYZuNwZvif2u+eFJx06ubGOBo1rCSAzVz8=
Message-ID: <438B0D89.1080400@gmail.com>
Date: Mon, 28 Nov 2005 22:00:41 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Marc Koschewski <marc@osknowledge.org>
CC: "Calin A. Culianu" <calin@ajvar.org>, akpm@osdl.org, adaplas@pol.net,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: nvidia fb flicker
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu> <20051128103554.GA7071@stiffy.osknowledge.org> <438AF8A2.6030403@gmail.com> <20051128132035.GA7265@stiffy.osknowledge.org>
In-Reply-To: <20051128132035.GA7265@stiffy.osknowledge.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Koschewski wrote:
> * Antonino A. Daplas <adaplas@gmail.com> [2005-11-28 20:31:30 +0800]:
> 
>> Marc Koschewski wrote:
>>> * Calin A. Culianu <calin@ajvar.org> [2005-11-26 00:02:46 -0500]:
>>>
>>>> Hi,
>>>>
>>>> This patch can be applied against 2.6.15-rc1 to add support to the 
>>>> nvidiafb driver for a few obscure (yet on-the-market) nvidia 
>>>> boards/chipsets, including various versions of the Geforce 6600 and 6200.
>>>>
>>>> This patch has been tested and allows the above-mentioned boards to get 
>>>> framebuffer console support.
>>>>
>>>> Thanks!
>>>>
>>>> -Calin
>>> Hi all,
>>>
>>> yesterday I compiled a 2.6.15-rc2 on one of my Inspirons (NVIDIA GeForce2 Go)
>>> with nvidiafb. I just changed the fb to some 1600x1200 mode and thus seems to
>>> work (the source states GeForce2 Go is supported and known). However, the
>>> letters seems to 'flicker' in some way. Uhm, it's not really flickering, it's
>>> more like the sinle dots a letter is made of seem to randomly turn on an off. I
>> Can you try booting with video=nvidiafb:1600x1200MR@60?
>>
>> If that still does not work, can you open drivers/video/fbmon.c then change
>> the line #undef DEBUG to #define DEBUG, recompile, reboot and post your
>> dmesg?
>>
>>> one takes a closer look it seems like the whole screen is 'fluent' or something.
>>> Does anybody know how to handle that? I didn't specify a video mode, but
>>> 'video=vesafb:mtrr:3'. 
>>>
>> No, remove any vga= and video=vesafb: strings in your boot options.
> 
> So, I just booted with the parameter given by you (and without vga= as usual), as
> well as without any parameter. No change though.
> 

Try again with CONFIG_FB_NVIDIA_I2C = n in your kernel config.

Tony

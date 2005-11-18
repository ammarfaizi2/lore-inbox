Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVKTVQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVKTVQk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVKTVQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:16:40 -0500
Received: from main.gmane.org ([80.91.229.2]:27034 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750734AbVKTVQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:16:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 18 Nov 2005 14:51:55 -0500
Message-ID: <dllbch$ar$1@sea.gmane.org>
References: <1132020468.27215.25.camel@mindpipe> <20051115185543.GI5735@stusta.de> <20051115222656.8D11816F4D9@smtp.lmc.cs.sunysb.edu> <200511181340.25529.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lmcgw.cs.sunysb.edu
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>> This issue raises a concern for me as developer of ndiswrapper. I
>> perceive that some kernel developers have strong opinions against
>> ndiswrapper. I see ndiswrapper as contributing my 2 cents - I have no
>> vested interests in ndiswrapper, although it will be sad to see lot of
>> effort and time put into ndiswrapper go waste.
> 
> Does it mean that you support ndiswrapper just because you wrote it?
> I understand this, but it's not a valid technical reason why
> it should be supported.

What logic did you use to infer that? I only said I am continuing to develop
ndiswrapper. "Vested interests" comment is to indicate that I have nothing
to gain by supporting ndiswrapper in Linux kernel; I am doing what I can so
people with unsupported wireless cards can use them in Linux.
 
> Companies got nice excuse for not giving us docs, making those
> months/years even longer.
> 
>> And so on. I
>> am not trying to argue in favor of ndiswrapper at the cost of open
>> source drivers, but that there is a genuine need for such a project,
>> at least for now.
> 
> Ok, how can we make any progress on obtaining docs for TI acx wireless
> chipset? Or on Prism54 "softmac" chipset? The reply is "Open source
> driver already exists (ndiswrapper), go away".

TI ACX chipset has been out long before ndiswrapper supported it. It has
been years since that chipset is out. In fact, ACX 100 chipset is no longer
made. Still the open source driver doesn't support WEP/WPA (I could be
wrong about current status, but at least until recently it was not). As I
said before, ndiswrapper is not competition to open source drivers - if
anything, it could be used to understand what the Windows driver does and
that may help in developing/improving open source driver.

> BTW, a few of wireless developers are interested in writing _open source
> firmware_ (not just driver) for these, and it is not that hard to do,
> if only we had the docs on components which make up the device.

I agree. But that is big "if".

> How can we hope to persuade companies into releasing that info
> when they are escaping from giving us even docs on "external" interface
> to their firmware with ndiswrapper argument, let alone on "internal"
> components?

This argument is debatable: There are wireless cards that didn't have
drivers even before ndiswrapper supported them. To claim that if they are
supported with anything less than an open source driver is hurting Linux is
one opinion. Given a choice, many people (I myself included) would chose
open source driver, but there are others that want to use the hardware they
have in Linux right now. Until an open source driver is available, I am
helping provide support for some hardware, so such people can use that
hardware in Linux.

I also would like to point out that using NDIS drivers in Linux is not
exactly same as using binary drivers: Whereas full-binary drivers hide
everything, NDIS drivers use an API to support the hardware (e.g., to
obtain/release a spinlcok, allocate/free memory etc). ndiswrapper
implements that API, so one can understand what an NDIS driver is doing at
the level of that API. 

Giri



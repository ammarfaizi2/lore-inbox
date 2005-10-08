Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVJHPab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVJHPab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 11:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVJHPab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 11:30:31 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:17930 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S932159AbVJHPaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 11:30:30 -0400
Message-ID: <4347E611.9040705@roarinelk.homelinux.net>
Date: Sat, 08 Oct 2005 17:30:25 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: Bernhard Rosenkraenzer <bero@arklinux.org>, linux-kernel@vger.kernel.org
Subject: Re: Modular i810fb broken, partial fix
References: <200510071547.14616.bero@arklinux.org> <4347A1E7.2050201@pol.net> <4347B3D6.5060700@roarinelk.homelinux.net> <4347C39F.2020703@pol.net>
In-Reply-To: <4347C39F.2020703@pol.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> Manuel Lauss wrote:
>>I tried the module on my i815 laptop, after modprobe the module does
>>nothing.
>>The call to pci_register_driver() returns 0, and thats it; the probe
>>function
>>does not get called. Same thing with Bernhard's patch applied. No problems
>>when compiled-in. Kernel 2.6.14-rc2-mm1, AGP compiled in, no DRM.
> 
> 
> That's weird.  Can you find out why the probe function is not called? Can

Stupid me, the i810_smbus driver grabbed the device and so the driver core
didn't probe i810fb against it.
With that one out of the way, modprobing i810fb with the appropriate parameters
correctly switches to graphics mode and fbcon gives me a nice console,
with and without Bernhard's patch.

for reference:
modprobe i810fb mode_option=1024x768-8@60 hsync1=40 hsync2=60 vsync1=50 vsync2=70 vram=4


-- 
  Manuel Lauss

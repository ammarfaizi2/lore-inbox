Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVJHL4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVJHL4O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 07:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVJHL4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 07:56:14 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:16645 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1750769AbVJHL4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 07:56:13 -0400
Message-ID: <4347B3D6.5060700@roarinelk.homelinux.net>
Date: Sat, 08 Oct 2005 13:56:06 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: Bernhard Rosenkraenzer <bero@arklinux.org>, adaplas@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Modular i810fb broken, partial fix
References: <200510071547.14616.bero@arklinux.org> <4347A1E7.2050201@pol.net>
In-Reply-To: <4347A1E7.2050201@pol.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> Bernhard Rosenkraenzer wrote:
> 
>>Hi,
>>i810fb as a module is broken (checked with 2.6.13-mm3 and 2.6.14-rc2-mm1).
>>It compiles, but the module doesn't actually load because the kernel doesn't 
>>recognize the hardware (the MODULE_DEVICE_TABLE statement is missing).
> 
> 
> 
>>The attached patch fixes this.
>>
>>However, the resulting module still doesn't work.
>>It loads, and then garbles the display (black screen with a couple of yellow 
>>lines, no matter what is written into the framebuffer device).
> 
> 
> Did you compile CONFIG_FRAMEBUFFER_CONSOLE statically, or did a modprobe fbcon?
> Does i810fb work if compiled statically?

I tried the module on my i815 laptop, after modprobe the module does nothing.
The call to pci_register_driver() returns 0, and thats it; the probe function
does not get called. Same thing with Bernhard's patch applied. No problems
when compiled-in. Kernel 2.6.14-rc2-mm1, AGP compiled in, no DRM.

thx,

-- 
  Manuel Lauss.

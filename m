Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUEVPiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUEVPiN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 11:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUEVPiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 11:38:13 -0400
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:48804
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S261231AbUEVPiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 11:38:11 -0400
Message-ID: <40AF73D5.5010202@winischhofer.net>
Date: Sat, 22 May 2004 17:37:57 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioctl number 0xF3
References: <40AF42B3.8060107@winischhofer.net> <1085228451.14486.0.camel@laptop.fenrus.com> <40AF4A13.4020005@winischhofer.net> <20040522125108.GB4589@devserv.devel.redhat.com> <40AF55AF.2020506@winischhofer.net> <20040522163214.A32228@electric-eye.fr.zoreil.com>
In-Reply-To: <20040522163214.A32228@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
 >He can surely tell when an egg stinks. However Arjan is not a chicken.

I didn't mean that as any sort of insult. I am just tired of the XFree86 
people telling me "implement a generic interface". I write one single 
driver and want the users of this driver to have some sort of comfort. 
Waiting until someone comes up with some generic solution (for a design 
of which I don't have time nor the required knowledge about a zillion 
different systems) I am old and grey.


> Thomas Winischhofer <thomas@winischhofer.net> :
>>Is 64 out of, what's that, 65536 too much to ask? Well, I could live 
>>with 32 as well...
>
> Reserving a generous ioctl range without any clear interface will make
> some people nervous. If you can not specify the interface now, try to
> separate the generic/specific part of it and use sub-ioctl for the really
> scary things as it will make the future life easier.
> 
> If you have some pointers to the existing code, that may help too.

Well, before I start implementing it (further), I thought it would be 
smart to be able to rely on certain things. As long as I don't even know 
if I get the numbers I don't write code... but frankly, the current 
development sisfb version available on my website has a very few of the 
intended ioctls already implemented.

The interface I intend to use matches the one the X driver has (using 
the Xv extension as an ioctl replacement) and will be documented. Since 
I develope both the SiS kernel framebuffer driver as well as the SiS X 
driver this will reduce duplicate code and ensures good cooperation. 
Furthermore, there could be a common library for both the framebuffer and X.

Hm. Were the matrox folks asked for a "clear interface" in advance when 
they started using the 'n' ioctls? Am I too polite? ;)

sisfb uses a few ioctls already, as an extension to the generic fb 
related ioctls. (Although the version currently in mainline 2.4 is not 
in any way 32/64 bit safe, and neiter is the mainline 2.6 version yet as 
regards the obviously required ioctl32 emulation stuff - investigating 
this at the moment).

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org

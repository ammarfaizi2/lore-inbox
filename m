Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbTIJDwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 23:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTIJDwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 23:52:47 -0400
Received: from postal.usc.edu ([128.125.253.6]:10977 "EHLO postal.usc.edu")
	by vger.kernel.org with ESMTP id S264519AbTIJDwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 23:52:20 -0400
Date: Tue, 09 Sep 2003 20:52:18 -0700
From: Phil Dibowitz <phil@ipom.com>
Subject: Re: Linux IDE bug in 2.4.21 and 2.4.22 ?
In-reply-to: <200309091701.48993.bzolnier@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Message-id: <3F5E9FF2.1050006@ipom.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827
 Debian/1.4-3
References: <20030908225107.GE17108@earthlink.net>
 <200309091448.36231.bzolnier@elka.pw.edu.pl> <3F5DE49E.50500@ipom.com>
 <200309091701.48993.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>>But, what about the case when I built in the generic driver, but made
>>the CMD649 driver a module, and loaded it after boot. That shouldn't
>>have *changed* what ide0 and ide1 are, right? I had ide0 and ide1
>>assigned, did a modprobe, and CMD649 changed what ide0 adn ide1 where,
>>and then forgot about the previous ones.. like all of a sudden it told
>>the generic driver "no, no, you were wrong, there's no VIA chipset here,
>>go back to sleep."
> 
> 
> Hmm. please send me dmesg.

OK,

I've posted the following:

GOOD WORKING CONFIG
http://phildev.net/config-working

GOOD WORKING DMESG
http://phildev.net/dmesg-working

NON WORKING CONFIG
http://phildev.net/config-bad

NON WORKING DMESG
http://phildev.net/dmesg-bad

As a recap...
For the non-working config, when I boot, the onboard VIA is recognized 
by the generic IDE driver, and then I did the dmesg, and then I 
modprobed CMD64X and it **reasigned** ide0 and ide1 to the PCI IDE 
card's chains and the original ide0 and ide1 disappeared, I therefore 
lost my hard drive, and the machine becomes unresponsive. I think that 
**might** be a bug in the CMD64X driver?

If I can provide more info, please let me know. I've kept the other 
kernel around so that I may boot into it if need be.

And as I said before, compiling hte VIA and CMD drivers both into the 
works fine on my machine, and I appreciate help getting that working, 
but I would like to either understand the above behavior, or know its a 
bug, or...

Thanks again for all your help. It really is much appreciated.

-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
  - Benjamin Franklin, 1759



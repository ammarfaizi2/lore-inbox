Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264925AbUD2Suq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUD2Suq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUD2Suq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:50:46 -0400
Received: from mail2.webmessenger.it ([193.70.193.55]:29635 "EHLO
	mail1a.webmessenger.it") by vger.kernel.org with ESMTP
	id S264925AbUD2Stf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:49:35 -0400
Message-ID: <40914C35.1030802@copeca.dsnet.it>
Date: Thu, 29 Apr 2004 20:40:53 +0200
From: Giuliano Colla <copeca@copeca.dsnet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.5) Gecko/20031007
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       hsflinux@lists.mbsi.ca
CC: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their	license
References: <408DC0E0.7090500@gmx.net>
In-Reply-To: <408DC0E0.7090500@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger ha scritto:

>Hi,
>
>LinuxAnt offers binary only modules without any sources. To circumvent our
>MODULE_LICENSE checks LinuxAnt has inserted a "\0" into their declaration:
>
>MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others, only
>LICENSE file applies");
>
>Since string comparisons stop at the first "\0" character, the kernel is
>tricked into thinking the modules are GPL. Btw, the "GPL" directory they
>are speaking about is empty.
>
>The attached patch blacklists all modules having "Linuxant" or "Conexant"
>in their author string. This may seem a bit broad, but AFAIK both
>companies never have released anything under the GPL and have a strong
>history of binary-only modules.
>
>
>Regards,
>Carl-Daniel
>  
>
<snip>

Let's try not to be ridiculous, please.

As an end user, if I buy a full fledged modem, I get some amount of 
proprietary, non GPL, code  which executes within the board or the 
PCMCIA card of the modem. The GPL driver may even support the 
functionality of downloading a new version of *proprietary* code into 
the flash Eprom of the device. The GPL linux driver interfaces with it, 
and all is kosher.
On the other hand, I have the misfortune of being stuck with a 
soft-modem, roughly the *same* proprietary code is provided as a binary 
file, and a linux driver (source provided) interfaces with it. In that 
case the kernel is flagged as "tainted".

But in both cases, if the driver is poorly written, because of 
developer's inadequacy, or because of the proprietary code being poorly 
documented and/or implemented, my kernel may go nuts, be it tainted or not.

Can you honestly tell apart the two cases, if you don't make a it a case 
of "religion war"?

For sake of completeness. *My* download of

https://www.linuxant.com/drivers/hsf/full/archive/hsfmodem-6.03.00lnxt04032800full/hsfmodem-6.03.00lnxt04032800full.tar.gz

contains, in the /modules/GPL/ directory the following files:

-rw-r--r--    1 colla    colla       18860 ago 23  2003 COPYING
-rw-r--r--    1 colla    colla       13609 gen 18 00:51 oscompat.h
-rw-r--r--    1 colla    colla       32573 mar 26 09:16 serial_cnxt.c
-rw-r--r--    1 colla    colla        3392 ago 23  2003 serial_cnxt.h
-rw-r--r--    1 colla    colla       57857 ago 24  2003 serial_core.c
-rw-r--r--    1 colla    colla        9789 ago 22  2003 serial_core.h

I strongly hope that developers' efforts will be addressed to more 
valuable topics than detecting the "Linuxant" string in a loadable 
module. Not forgetting  that Linux\0ant, L\0inuxant, etc. would display 
the same way ;-)

Kind Regards

-- 
Ing. Giuliano Colla
Direttore Tecnico
Copeca srl
Bologna 
Italy




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267017AbUBMPKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267033AbUBMPKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:10:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:17896 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S267017AbUBMPKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:10:37 -0500
Message-ID: <402CE89F.9060404@paceblade.com>
Date: Fri, 13 Feb 2004 16:09:19 +0100
From: Robert Woerle <robert@paceblade.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040113
X-Accept-Language: de, en, de-at, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: serial.c - start looking from 0x220 iomem_base  ??
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:b4ac6117e991eeeca15f2be66d9fb0df
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am having here a device  (Tablet PC ) sample with a serial resistive 
touchscreen  .
Under Windows it comes up as COM1 at IO-Base 0x220 -0x227 IRQ 4 .
Now it seems that in linux the serial driver doesnt look for so "low" 
I/O-Base `s .

By hacking around by hardcoding the 0x220 somehwere in serial.c i get it 
to detect a standard 16550 , but
unfortunately it then assumes that all ttySX have this base .
This is because of my hardcoded hack and the driver not looking for all 
the rest mem bases.

So the quesion is :
Where do i tell serial.o  to start lower ( at 0x220 ) to look for 
controllers .. .??



Pls also CC me directly since i am only monitoring this list .


-- 
____________________________________
*Robert Woerle
*
*Technical Product Manager

2L Computers BV*
*
*Niederlassung Deutschland*
*Pace/Blade/ /- /Commodore - Conceptronic*
** 
*
phone: 	+49 89 552 999 34
fax: 	+49 89 552 999 10
email: 	robert@paceblade.com <mailto:robert@paceblade.com>
web: 	http://www.paceblade.com <http://www.paceblade.com/>
_____________________________________








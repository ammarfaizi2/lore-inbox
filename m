Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTFQRva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 13:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTFQRv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 13:51:29 -0400
Received: from [62.75.136.201] ([62.75.136.201]:45696 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264448AbTFQRv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 13:51:26 -0400
Message-ID: <3EEF585E.9030404@g-house.de>
Date: Tue, 17 Jun 2003 20:05:18 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.71 compile error on alpha
References: <3EEE4A14.4090505@g-house.de> <wrpr85te3fa.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpr85te3fa.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier schrieb:
> Please try this patch :
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105540998415031&w=2
> 

ok, that did it, but then another error showed up:

[...]
   AS      arch/alpha/lib/stxcpy.o
   AS      arch/alpha/lib/stxncpy.o
   CC      arch/alpha/lib/udelay.o
   AR      arch/alpha/lib/lib.a
   CPP     arch/alpha/vmlinux.lds.s
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      vmlinux
net/built-in.o(.init.text+0x484): In function `flow_cache_init':
: undefined reference to `register_cpu_notifier'
net/built-in.o(.init.text+0x488): In function `flow_cache_init':
: undefined reference to `register_cpu_notifier'
make: *** [vmlinux] Error 1
lila:/usr/src/linux-2.5#

oh, just before vmlinux was made! before & after applying the patch i 
did "make clean" (do i have to make clean "before" applying patches 
anyway? after applying patches and before making targets, yes.)

oh, and this alpha is named "Avanti" but a kernel compile needs 80mins 
or so :-)

Thank you,
Christian.


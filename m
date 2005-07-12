Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVGLIFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVGLIFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVGLIFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:05:50 -0400
Received: from acheron.ifi.lmu.de ([129.187.214.135]:58061 "EHLO
	acheron.ifi.lmu.de") by vger.kernel.org with ESMTP id S261248AbVGLIFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:05:46 -0400
Message-ID: <42D379D6.5080705@bio.ifi.lmu.de>
Date: Tue, 12 Jul 2005 10:05:42 +0200
From: Frank Steiner <fsteiner-mail1@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Steiner <fsteiner-mail1@bio.ifi.lmu.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, davem@redhat.com,
       jgarzik@pobox.com
Subject: Re: tg3 fails with x86_64 (but works with i386) 
References: <42D22059.8000607@bio.ifi.lmu.de>
In-Reply-To: <42D22059.8000607@bio.ifi.lmu.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner wrote

> Hi,
> 
> I've two 3com 3C996B-T network cards (lspci says it's
> a Broadcom BCM5701 chip) in Asus A8V boards with an
> AMD64 4000+ cpu. Booting a x86_64 version of the
> 2.6.12.2 kernel, the tg3 module complains
> 
>    tg3.c: v3.31 (June 8, 2005)
>    tg3_test_dma() Write the buffer failed -19
>    tg3: DMA engine test failed, aborting.


I could solve this: The A8V boards have (like all 64bit boards I guess?)
an option for memory remapping around the memory hole at 3.5GB. When
this remapping is activated, the tg3 driver fails with the error message
above. If the remapping is deactivated, the driver and the card work fine
(but linux can only work with 3.7 of the 4GB). But I need to have the
remapping deactivated anyway, because the fglrx driver won't work
either otherwise.

cu,
FRank


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *

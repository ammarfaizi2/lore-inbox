Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSERKIg>; Sat, 18 May 2002 06:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSERKIf>; Sat, 18 May 2002 06:08:35 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:13812 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293680AbSERKIe>; Sat, 18 May 2002 06:08:34 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3CE55009.9050505@colorfullife.com> 
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "'Roger Luethi'" <rl@hellgate.ch>, linux-kernel@vger.kernel.org,
        Shing Chuang <ShingChuang@via.com.tw>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 18 May 2002 11:08:15 +0100
Message-ID: <15836.1021716495@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


manfred@colorfullife.com said:
> IIRC all register reads from the addresses that belong to a pulled out
>  PCMCIA card return 0xFFFFFFFF ;-) 

Not necessarily. It can lock up the bus and require a hard reset.

That's why they make some pins longer than others -- so you can get an
interrupt which lets you know it's going away a split second before it's
actually gone, and you have time to remove power from the socket and call
some kind of abort method on the driver so it knows it must never touch
the hardware again.

--
dwmw2



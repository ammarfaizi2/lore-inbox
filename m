Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbRBLXiD>; Mon, 12 Feb 2001 18:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129500AbRBLXhx>; Mon, 12 Feb 2001 18:37:53 -0500
Received: from front1.grolier.fr ([194.158.96.51]:40436 "EHLO
	front1.grolier.fr") by vger.kernel.org with ESMTP
	id <S129421AbRBLXhq>; Mon, 12 Feb 2001 18:37:46 -0500
Message-ID: <3A8873F3.772D75E7@club-internet.fr>
Date: Tue, 13 Feb 2001 00:38:27 +0100
From: Jérôme Augé <jauge@club-internet.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-pre3 i586)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: opl3sa not detected anymore
In-Reply-To: <Pine.LNX.4.30.0102122311180.1057-100000@pikachu.bti.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Funderburg wrote:
> following in /etc/modules.conf:
> 
> alias sound-slot-0 opl3sa2
> options sound dmabuf=1
> alias midi opl3
> options opl3 io=0x388
> options opl3sa2 mss_io=0x530 irq=5 dma=1 dma2=0 mpu_io=0x330 io=0x370
> 
> The midi works fine, but 'modprobe sound' reports:
> 
> opl3sa2: No cards found
> opl3sa2: 0 PnP card(s) found.
> 
> If the settings above look ok, then how can help debug it?

Try to add "isapnp=0" to the opl3sa2 options list :

opl3sa2 mss_io=0x530 irq=5 dma=1 dma2=0 mpu_io=0x330 io=0x370 isapnp=0

I had the same problem and adding isapnp=0 solved it, but PNP isn't
supposed to automaticaly detect those options ?

-- 
Jérôme Augé
echo cdqgm@vnqb-hklmpkml.yp | tr khplmndvqyc nirtelacufj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/

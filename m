Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130155AbRBLPEb>; Mon, 12 Feb 2001 10:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130174AbRBLPEV>; Mon, 12 Feb 2001 10:04:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28946 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130155AbRBLPEH>; Mon, 12 Feb 2001 10:04:07 -0500
Subject: Re: Bug in i810 kernel module
To: stephane@antefacto.com
Date: Mon, 12 Feb 2001 15:04:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0102121440560G.00759@steph> from "Stephane Dudzinski" at Feb 12, 2001 02:40:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SKWq-0007Dc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've compiled the brand new 2.4.1 with the i810 module (the one which plays 
> mp3s 15% faster than the usual speed). I did a hack modifying this line into :
> /usr/src/linux/drivers/sound/i810_audio.c and modified the clocking as 
> follows : 
> 
> static unsigned int clocking=41194;
> 
> I don't think this why i got this behavior but using xmms sucked 98% of the 
> CPU time reading either mp3s or ogg files. Something is definitly wrong with 
> this driver as ALSA ones work just fine (xmms then uses only 0.5% of the CPU 
> time).

Or something is wrong with xmms. Right now I dont know which. I can tell you
the speed thing is unrelated. Certain vendors wire the ac97 codecs to the wrong
clock to save board space/crystals - notably dell laptops. That is why the
clocking value is a module option and you can select 'fix the sound on dell'
mode with the module option ftsodell=1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/

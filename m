Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130333AbRBWUs3>; Fri, 23 Feb 2001 15:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132021AbRBWUr3>; Fri, 23 Feb 2001 15:47:29 -0500
Received: from jalon.able.es ([212.97.163.2]:15503 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129669AbRBWUqW>;
	Fri, 23 Feb 2001 15:46:22 -0500
Date: Fri, 23 Feb 2001 21:46:02 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac3
Message-ID: <20010223214602.A3731@werewolf.able.es>
In-Reply-To: <E14WOAk-0006y9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14WOAk-0006y9-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 23, 2001 at 20:46:31 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.23 Alan Cox wrote:
> 
>         Handle with care.. Its possible the ioremap debugging change
>         might remove casts that hid older problems in a few drivers
> 
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 2.4.2-ac3

make xconfig:

/tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/scsi/pcmcia/Config.in: 20: unterminated 'if' condition

Misses a backslash at EOL.
if [ "$CONFIG_PCMCIA_QLOGIC" = "y" -o "$CONFIG_PCMCIA_AHA152X" = "y" -o \
     "$CONFIG_PCMCIA_FDOMAIN" = "y" -o "$CONFIG_PCMCIA_APA1480" = "y" -o
                                                                      ^^^^^^^
     "$CONFIG_PCMCIA_NINJA_SCSI" ]; then
   define_bool CONFIG_PCMCIA_SCSICARD y
fi

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac1 #2 SMP Fri Feb 23 02:34:42 CET 2001 i686


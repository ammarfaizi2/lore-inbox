Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135266AbRD3U0c>; Mon, 30 Apr 2001 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135239AbRD3U0W>; Mon, 30 Apr 2001 16:26:22 -0400
Received: from adsl-63-206-198-42.dsl.snfc21.pacbell.net ([63.206.198.42]:28876
	"EHLO adsl-63-206-198-42.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S135283AbRD3U0F>; Mon, 30 Apr 2001 16:26:05 -0400
Date: Mon, 30 Apr 2001 13:22:59 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Elmer Joandi <elmer@linking.ee>, Ookhoi <ookhoi@dds.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Aironet doesn't work
In-Reply-To: <3AEDB0D4.2CB47196@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0104301319570.30974-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Jeff Garzik wrote:

> Francois Gouget wrote:
> > CONFIG_PCMCIA=y
> > CONFIG_CARDBUS=y
> > CONFIG_I82365=y
> 
> Not correct -- you do not need I82365 if you have CardBus.  However, if
> you are running 2.4.4 you should be ok.

   Ok. I upgraded to 2.4.4 and modified my config file to be:

CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_I82365 is not set

   But now I get the same missing symbols I initially had in 2.4.3:

Apr 30 13:19:34 oleron cardmgr[148]: initializing socket 0
Apr 30 13:19:34 oleron cardmgr[148]: socket 0: Aironet PC4800
Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_core'
Apr 30 13:19:34 oleron cardmgr[148]: + Warning: /lib/modules/2.4.4/kernel/drivers/net/aironet4500_core.o 
symbol for parameter rx_queue_len not found
Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_proc'
Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_cs'
Apr 30 13:19:35 oleron cardmgr[148]: get dev info on socket 0
failed: Resource temporarily unavailable


--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
                            1 + e ^ ( i * pi ) = 0


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271801AbRHWKuX>; Thu, 23 Aug 2001 06:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272170AbRHWKuO>; Thu, 23 Aug 2001 06:50:14 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:37130 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S271801AbRHWKuD>;
	Thu, 23 Aug 2001 06:50:03 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 23 Aug 2001 11:11:22 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gunther Mayer <Gunther.Mayer@t-online.de>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
Message-ID: <20010823111122.B1143@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15Zca4-0001z2-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 07:18:20PM +0100, Alan Cox wrote:
> > Try -ac Kernels with integrated PNPBIOS and "lspnp -v",
> > then you will see your "motherboard resources". No magic.
> 
> Except on the intel boards [ ... bios bugs list snipped ... ] 

2.4.8-ac8 works for me, and lspnp does list these "obscure"
ressources:

bytesex kraxel ~# /root/bin/lspnp -v
00 PNP0c01 memory controller: RAM
        mem 0x00000000-0x0009ffff
        mem 0x00100000-0x0bfdffff
        mem 0x0bfe0000-0x0bfeffff
        mem 0x000e0000-0x000fffff
        mem 0xffff0000-0xffffffff
        io 0x0398-0x0399
        io 0x0024-0x003d
        io 0x0062-0x0062
        io 0x0066-0x0066
        io 0x0090-0x009f
        io 0x00a4-0x00bd
        io 0x0230-0x0233
        io 0x1000-0x103f
        io 0x1400-0x140f
        io 0x3810-0x381f

01 PNP0c02 reserved: other
        io 0x0cf8-0x0cff
        io 0x04d0-0x04d1

02 PNP0c04 system peripheral: other
        irq 13
        io 0x00f0-0x00ff

03 PNP0000 system peripheral: programmable interrupt controller
[ ... more standard PC hardware follows ... ]

But it seems they are _not_ reserved by the pnp bios code, at least they
are not listed in /proc/ioports

> Before PnPBIOS can go mainstream we'd have to generate a detailed list
> of buggy bios signatures

Why?  It shouldn't harm if disabled, so IMHO it should be fine when
flagged "experimental" and with a warning label about broken bioses in
Configure.help ...

  Gerd

-- 
Damn lot people confuse usability and eye-candy.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132962AbRDES3Q>; Thu, 5 Apr 2001 14:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132963AbRDES3G>; Thu, 5 Apr 2001 14:29:06 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:10765 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S132962AbRDES2q>; Thu, 5 Apr 2001 14:28:46 -0400
Message-ID: <3ACCB923.645F42E4@vc.cvut.cz>
Date: Thu, 05 Apr 2001 11:27:47 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Wade Hampton <whampton@staffnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3
In-Reply-To: <20010330190137.A426@indiana.edu> <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com> <20010403202127.A316@bacchus.dhis.org> <3ACB2323.C1653236@mips.com> <3ACB3CA5.D978EF41@staffnet.com> <3ACB8098.DFEC12D7@vc.cvut.cz> <2001040423 <3ACC1E35.4D2F7506@mips.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Langgaard wrote:
> 
> Petr Vandrovec wrote:

> > Current Linux driver switches them to 16bit mode in pcnet_probe1:
> >
> > pcnet_dwio_reset(); // reset to 16bit mode when in 32bit, ignore in
> > 16bit mode
> > pcnet_wio_reset();  // device is for sure in 16bit mode, but reset it
> > again to

> I'm afraid that's not true.
> The above only do a software reset and that doesn't effect the I/O mode.
> Only a hardware reset effects the I/O mode.
> An because any firmware might changes to 32bit mode after reset (of the whole
> system), we need to support both modes.

Oops. I misinterpreted what code does. Really stupid hardware.
							Thanks,
								Petr Vandrovec
								vandrove@vc.cvut.cz

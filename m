Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRCUFKZ>; Wed, 21 Mar 2001 00:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131206AbRCUFKP>; Wed, 21 Mar 2001 00:10:15 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:12298 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S131205AbRCUFJ4>; Wed, 21 Mar 2001 00:09:56 -0500
Message-ID: <3AB83740.B54D67BA@vc.cvut.cz>
Date: Wed, 21 Mar 2001 06:08:16 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
Organization: Czech Technical University - Computing and Information Centre
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: cs,cz,en
MIME-Version: 1.0
To: German Gomez Garcia <german@piraos.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Matrox framebuffer dualhead and utilities
In-Reply-To: <20010320191543.23457.qmail@piraos.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

German Gomez Garcia wrote:

>         I'm trying to set the Matrox framebuffer to dualhead or TV output,
> but the utilities mentioned in the docs seem to be outdated (ioctl failed
> with incorrect command). Any idea about where to get up to date tools?
> I'm using kernel 2.4.2-ac20 (quite stable 5 days uptime with heavy DRI
> testing and heavy disk working).

matroxset-0.3 is latest one. You are probably doing something wrong:
(1) With fbset you are trying to use 8bpp or 24bpp color depth.
Secondary
    head supports only 16/32bpp.
(2) You did not insmod all needed modules if you compiled matroxfb as
    modular (you should compile everything into the kernel...)
(3) You are trying to do some illegal thing, like connecting both
    /dev/fb0 and /dev/fb1 into same output...
							Petr Vandrovec
							vandrove@vc.cvut.cz

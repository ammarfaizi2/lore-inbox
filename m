Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRADRC3>; Thu, 4 Jan 2001 12:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbRADRCT>; Thu, 4 Jan 2001 12:02:19 -0500
Received: from pop.gmx.net ([194.221.183.20]:10736 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129927AbRADRCK>;
	Thu, 4 Jan 2001 12:02:10 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.0-prerelease: System dies after leaving XF86_4.0.2
Date: Thu, 4 Jan 2001 17:56:45 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14EBUX-0005nN-00@the-village.bc.nu>
In-Reply-To: <E14EBUX-0005nN-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01010417564500.11030@nmb>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan,

my graphic card is a matrox 1- video card is a haupauge/model618pci , no AGP 
or DRM. The output of ver_linux + lsmod below. There has to be significant 
change from test13pre7 to prerelease ff. There is an immediate standstill, 
nothing in /var/log/messages or /var/log/warn.

kind regards
Norbert 

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux nmb 2.4.0-test12 #1 SMP Thu Jan 4 04:56:00 CET 2001 i586 unknown
Kernel modules         2.3.24
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4070534 Sep  5 18:07 
/lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         ppp_deflate bsd_comp ppp_async ppp_generic tuner 
tvaudio msp3400 bttv videodev i2c-algo-bit i2c-core pnp emu8k opl3 sb uart401 
midi soundbase sndshield ipv6 8139too serial

===================================================================
nmb:~ # lsmod
Module                  Size  Used by
ppp_deflate            39616   0  (autoclean)
bsd_comp                4256   0  (autoclean)
ppp_async               6608   0  (autoclean)
ppp_generic            15456   0  (autoclean) [ppp_deflate bsd_comp ppp_async]
tuner                   3248   1  (autoclean)
tvaudio                 7936   0  (autoclean) (unused)
msp3400                13392   1  (autoclean)
bttv                   56112   1  (autoclean)
videodev                4864   4  (autoclean) [bttv]
i2c-algo-bit            7232   1  (autoclean) [bttv]
i2c-core               13136   0  (autoclean) [tuner tvaudio msp3400 bttv 
i2c-algo-bit]
pnp                    50096   3 
emu8k                  40128   3 
opl3                   14496   3 
sb                     35232   3 
uart401                 8000   3  [sb]
midi                   30224   3  [pnp emu8k opl3 sb uart401]
soundbase             314688   3  [pnp emu8k opl3 sb uart401 midi]
sndshield              10336   0  [pnp emu8k opl3 sb uart401 midi soundbase]
ipv6                  147280  -1  (autoclean)
8139too                15712   1  (autoclean)
serial                 43056   0  (autoclean)


==================================================================================
On Thursday 04 January 2001 15:35, Alan Cox wrote:
> > I've tested 2.4.0prerelease pure - ac1-ac2-ac3-ac4-ac5 and my system
> > crashed whenever I left X.
> > Having switched back to 2.4.0-test13pre7 all is fine.
> > I'm no developer, so if you need more information, give me some hints.
>
> What video card do you have and are you using AGP or DRM (an lsmod will
> tell you)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265561AbSJSJHy>; Sat, 19 Oct 2002 05:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbSJSJHx>; Sat, 19 Oct 2002 05:07:53 -0400
Received: from ulima.unil.ch ([130.223.144.143]:11136 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S265561AbSJSJHw>;
	Sat, 19 Oct 2002 05:07:52 -0400
Date: Sat, 19 Oct 2002 11:13:53 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.42-ac1 can't compil isdn (obsolete) and how to use ISDN under 2.5?
Message-ID: <20021019091353.GA17315@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  gcc -Wp,-MD,drivers/isdn/i4l/.isdn_ppp.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=isdn_ppp   -c -o drivers/isdn/i4l/isdn_ppp.o drivers/isdn/i4l/isdn_ppp.c
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_free':
drivers/isdn/i4l/isdn_ppp.c:122: `lp' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c:122: (Each undeclared identifier is reported only once
drivers/isdn/i4l/isdn_ppp.c:122: for each function it appears in.)
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_bind':
drivers/isdn/i4l/isdn_ppp.c:209: `lp' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_init':
drivers/isdn/i4l/isdn_ppp.c:1374: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1385: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1386: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1387: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1390: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1393: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1394: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1395: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1397: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_receive':
drivers/isdn/i4l/isdn_ppp.c:1415: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1425: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1426: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1562: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_cleanup':
drivers/isdn/i4l/isdn_ppp.c:1634: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1638: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1641: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_reassembly':
drivers/isdn/i4l/isdn_ppp.c:1693: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_bundle':
drivers/isdn/i4l/isdn_ppp.c:1766: warning: implicit declaration of function `isdn_net_findif'
drivers/isdn/i4l/isdn_ppp.c:1766: warning: assignment makes pointer from integer without a cast
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_dial_slave':
drivers/isdn/i4l/isdn_ppp.c:1910: warning: assignment makes pointer from integer without a cast
drivers/isdn/i4l/isdn_ppp.c:1917: structure has no member named `slave'
drivers/isdn/i4l/isdn_ppp.c:1921: structure has no member named `slave'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_hangup_slave':
drivers/isdn/i4l/isdn_ppp.c:1939: warning: assignment makes pointer from integer without a cast
drivers/isdn/i4l/isdn_ppp.c:1946: structure has no member named `slave'
make[3]: *** [drivers/isdn/i4l/isdn_ppp.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2

Without synchronous PPP it compils perfectly ;-)
But as it oops on boot that way ;-((

I have:

03:00.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card ISDN Controller
        Flags: medium devsel, IRQ 16
        Memory at dfefefe0 (32-bit, non-prefetchable) [size=32]
        I/O ports at b800 [size=32]

As I have "only" an A1 card, could I use the new ISDN or not?

I am sorry to ask, but the doc seems quiete confusing for me???
Under obsolete driver everything works just perfectly, but I don't
manage using the CAPI 2 :-(

I have looked at http://alumni.caltech.edu/~dank/isdn without much
sucess...

Could someone point me where I could find an explanation of what's
possible now?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265516AbSKYTXP>; Mon, 25 Nov 2002 14:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbSKYTXP>; Mon, 25 Nov 2002 14:23:15 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:38840
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265516AbSKYTXK> convert rfc822-to-8bit; Mon, 25 Nov 2002 14:23:10 -0500
Date: Mon, 25 Nov 2002 14:33:57 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: e7500 and IRQ assignment
In-Reply-To: <200211251934.47959.gabrielli@roma2.infn.it>
Message-ID: <Pine.LNX.4.50.0211251429070.1462-100000@montezuma.mastecende.com>
References: <233C89823A37714D95B1A891DE3BCE5202AB1994@xch-a.win.zambeel.com>
 <200211251618.28510.gabrielli@roma2.infn.it>
 <Pine.LNX.4.50.0211251038280.1462-100000@montezuma.mastecende.com>
 <200211251934.47959.gabrielli@roma2.infn.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Emiliano Gabrielli wrote:

> On 16:41, lunedì 25 novembre 2002, Zwane Mwaikambo wrote:
> > On Mon, 25 Nov 2002, Emiliano Gabrielli wrote:
> > > number of MP IRQ sources: 20.
> > > number of IO-APIC #2 registers: 24.
> > > number of IO-APIC #3 registers: 24.
> > > number of IO-APIC #4 registers: 24.
> > > number of IO-APIC #5 registers: 24.
> > > number of IO-APIC #6 registers: 24.
> > > testing the IO APIC.......................
> >
> > Out of curiosity, does this box really have 5 IOAPICs?
> >
> > 	Zwane
>
> no of course, but something seems to be buggy...
>
> ..  nothing changed ;((

Can't be certain without more debug output from MP boot process,
perhaps MP table parsing? Do you have ACPI enabled?

Please humour me here (you only have 20 IRQ sources and everything looks
properly wired on IOAPIC#2 ;)

Index: linux-2.4.20-rc1-ac4/include/asm-i386/apicdef.h
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-rc1-ac4/include/asm-i386/apicdef.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apicdef.h
--- linux-2.4.20-rc1-ac4/include/asm-i386/apicdef.h	18 Nov 2002 01:38:42 -0000	1.1.1.1
+++ linux-2.4.20-rc1-ac4/include/asm-i386/apicdef.h	25 Nov 2002 19:30:45 -0000
@@ -115,7 +115,7 @@
 #ifdef CONFIG_MULTIQUAD
 #define MAX_IO_APICS	32
 #else
-#define MAX_IO_APICS	8
+#define MAX_IO_APICS	1
 #endif

 #define		APIC_BROADCAST_ID_XAPIC		0xFF

--
function.linuxpower.ca

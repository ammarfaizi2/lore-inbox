Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312719AbSCZVGr>; Tue, 26 Mar 2002 16:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312720AbSCZVGh>; Tue, 26 Mar 2002 16:06:37 -0500
Received: from pool-151-204-73-76.delv.east.verizon.net ([151.204.73.76]:516
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S312719AbSCZVGW>; Tue, 26 Mar 2002 16:06:22 -0500
Date: Tue, 26 Mar 2002 16:06:38 -0500
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre4-ac1 vmware and emu10k1 problems
Message-ID: <20020326160638.A2103@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vmware modules will not compile properly under 2.4.19-pre4-ac1, or
under 2.4.19-pre2-ac2, but compile fine on their mainline kernel
counterparts.  Here is the errors that I get from vmware-config.pl:

Building the vmmon module.

make: Entering directory `/tmp/vmware-config1/vmmon-only'
make[1]: Entering directory `/tmp/vmware-config1/vmmon-only'
make[2]: Entering directory
`/tmp/vmware-config1/vmmon-only/driver-2.4.19-pre4-ac1'
In file included from .././linux/driver.c:38:
/lib/modules/2.4.19-pre4-ac1/build/include/linux/malloc.h:4: #error
linux/malloc.h is deprecated, use linux/slab.h instead.
make[2]: *** [driver.d] Error 1
make[2]: Leaving directory
`/tmp/vmware-config1/vmmon-only/driver-2.4.19-pre4-ac1'
make[1]: *** [deps] Error 2
make[1]: Leaving directory `/tmp/vmware-config1/vmmon-only'
make: *** [auto-build] Error 2
make: Leaving directory `/tmp/vmware-config1/vmmon-only'
Unable to build the vmmon module.


Also, under 2.4.19-pre4-ac1, when the emu10k1 module is loaded, I get a
large amount of constant static until I rmmod it.  2.4.19-pre4's
initialization of the emu10k1 driver is fine, and when the emu10k1
driver is replaced with the latest CVS version of the emu10k1 driver,
it initializes and performs normally.

--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net:8008/~magamo/index.htm

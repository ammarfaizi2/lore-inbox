Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312861AbSC0AAe>; Tue, 26 Mar 2002 19:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312855AbSC0AAY>; Tue, 26 Mar 2002 19:00:24 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:12750 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S312860AbSC0AAO>; Tue, 26 Mar 2002 19:00:14 -0500
Date: Wed, 27 Mar 2002 00:00:06 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: Malcolm Mallardi <magamo@ranka.2y.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre4-ac1 vmware and emu10k1 problems
In-Reply-To: <20020326160638.A2103@trianna.upcommand.net>
Message-ID: <Pine.LNX.4.44.0203262358040.14489-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They'll fix it eventually / in the 3.1 release, but you can look in
the source tarballs and change the #include to include slab.h instead
of malloc.h if you're impatient. 

See: /usr/lib/mvmware/modules/source/*.tar

Mark

On Tue, 26 Mar 2002, Malcolm Mallardi wrote:

> Date: Tue, 26 Mar 2002 16:06:38 -0500
> From: Malcolm Mallardi <magamo@ranka.2y.net>
> To: linux-kernel@vger.kernel.org
> Subject: 2.4.19-pre4-ac1 vmware and emu10k1 problems
> 
> The vmware modules will not compile properly under 2.4.19-pre4-ac1, or
> under 2.4.19-pre2-ac2, but compile fine on their mainline kernel
> counterparts.  Here is the errors that I get from vmware-config.pl:
> 
> Building the vmmon module.
> 
> make: Entering directory `/tmp/vmware-config1/vmmon-only'
> make[1]: Entering directory `/tmp/vmware-config1/vmmon-only'
> make[2]: Entering directory
> `/tmp/vmware-config1/vmmon-only/driver-2.4.19-pre4-ac1'
> In file included from .././linux/driver.c:38:
> /lib/modules/2.4.19-pre4-ac1/build/include/linux/malloc.h:4: #error
> linux/malloc.h is deprecated, use linux/slab.h instead.
> make[2]: *** [driver.d] Error 1
> make[2]: Leaving directory
> `/tmp/vmware-config1/vmmon-only/driver-2.4.19-pre4-ac1'
> make[1]: *** [deps] Error 2
> make[1]: Leaving directory `/tmp/vmware-config1/vmmon-only'
> make: *** [auto-build] Error 2
> make: Leaving directory `/tmp/vmware-config1/vmmon-only'
> Unable to build the vmmon module.
> 
> 
> Also, under 2.4.19-pre4-ac1, when the emu10k1 module is loaded, I get a
> large amount of constant static until I rmmod it.  2.4.19-pre4's
> initialization of the emu10k1 driver is fine, and when the emu10k1
> driver is replaced with the latest CVS version of the emu10k1 driver,
> it initializes and performs normally.
> 
> --
> Malcolm D. Mallardi - Dark Freak At Large
> "Captain, we are receiving two-hundred eighty-five THOUSAND hails."
> AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
> http://ranka.2y.net:8008/~magamo/index.htm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132036AbQLVRLk>; Fri, 22 Dec 2000 12:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132084AbQLVRLa>; Fri, 22 Dec 2000 12:11:30 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:27143 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S132036AbQLVRLQ> convert rfc822-to-8bit; Fri, 22 Dec 2000 12:11:16 -0500
Date: Fri, 22 Dec 2000 17:35:38 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@valinux.com>
Subject: Re: FAIL: 2.2.18 + AA-VM-global-7 + serial 5.05
Message-ID: <20001222173538.A12949@krusty.e-technik.uni-dortmund.de>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org Theodore Ts'o <tytso@valinux.com>
In-Reply-To: <20001222154757.A1167@emma1.emma.line.org> <20001222162159.A29397@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001222162159.A29397@athlon.random>; from andrea@suse.de on Fri, Dec 22, 2000 at 16:21:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli schrieb am Freitag, den 22. Dezember 2000:

> On Fri, Dec 22, 2000 at 03:47:57PM +0100, Matthias Andree wrote:
> > I suspect that these patches are mutually incompatible.
> 
> did you checked that there are no rejects after patching :)

Yes, I did, there were none.

I had one patch that required a fuzz factor, but it only has a vendor ID
definition in pci.h. It's the patch by Lukasz Trabinski, Subject "Re:
[patch] 2.2.18 PCI_DEVICE_ID_OXSEMI_16PCI954", Date 2000-12-16 19:51
EST, Archive at
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0012.2/0126.html

That patch has been approved by Theodore Y Tso as being correct.

The other patches I applied did not leave any rejects behind.

> > Could somebody please have a look at this? I will test or provide more
> > information as requested.
> 
> Where's serial 5.05 so I can have a look?

It's at http://sourceforge.net/projects/serial/ and since these are down
ATM, I'm keeping a copy at
http://www-dt.e-technik.uni-dortmund.de/~ma/kernelpatches/v2.2/v2.2.18/

Procedure:

1. fetch 2.2.18-fix-serial-5.05-pre.patch (has also been posted here, it
   just adds a missing #define to pci.h)
2. fetch serial-5.05.tar.gz
3. patch the kernel with that 2.2.18-fix-serial-5.05-pre.patch, it takes
   a high fuzz factor (try patch -p1 -F10)
4. unpack serial-5.05
5. sh install-in-kernel
6. patch with VM-global-2.2.18pre25-7
7. make clean dep bzImage modules, install, boot, and see it hang.

Note my kernel also contains the IDE and I²C patches, should that
matter, if it matters, please tell the corresponding maintainer there's
an incompatibility.

For what it's worth, that www-dt server directory also has my config,
it's named config-ma2.

-- 
Matthias Andree



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

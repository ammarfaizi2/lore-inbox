Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKABZe>; Tue, 31 Oct 2000 20:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129615AbQKABZZ>; Tue, 31 Oct 2000 20:25:25 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:65295 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129050AbQKABZU>; Tue, 31 Oct 2000 20:25:20 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBE5@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: "'Keith Owens'" <kaos@ocs.com.au>,
        "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'linus'" <torvalds@transmeta.com>
Subject: RE: test10-pre7 (LINK ordering)
Date: Tue, 31 Oct 2000 17:24:24 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > With CONFIG_USB=y and all other USB modules built as
> > > modules (=m), linking usbdrv.o into the kernel image
> > > gives this:
> > 
> > > drivers/usb/usbdrv.o(.data+0x2f4): undefined reference to
> > 
> > Works for me here, .config attached.  Local changes, merge error, or
> > similar?  I don't have any local USB patches...
> 
> I agree.  My (rushed) bad.
> Didn't rm usb/*.o .
> 
> Thanks for catching me.  I'm pleased that there's
> no problem here.

Hi Jeff,

Did I speak too quickly again?

Can you successfully do 'depmod -ae' _before_
booting this kernel?

I still get lots of unresolved USB symbols in
all USB modules.

Is it valid to run depmod like this before
booting the kernel that has usbcore in-kernel?
depmod -ae works after I boot that kernel + usbcore.

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

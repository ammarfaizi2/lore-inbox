Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136493AbREGRwp>; Mon, 7 May 2001 13:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136483AbREGRwe>; Mon, 7 May 2001 13:52:34 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:48298 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S136468AbREGRwX>; Mon, 7 May 2001 13:52:23 -0400
Message-Id: <5.1.0.14.2.20010507184618.00a8a5b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 May 2001 18:52:49 +0100
To: "Dunlap, Randy" <randy.dunlap@intel.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: RE: [PATCH] x86 page fault handler not interrupt safe 
Cc: "'David Woodhouse'" <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE26F@orsmsx31.jf.intel
 .com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:32 07/05/2001, Dunlap, Randy wrote:
> > From: David Woodhouse [mailto:dwmw2@infradead.org]
> >
> > torvalds@transmeta.com said:
> > >  If anybody has such a beast, please try this kernel patch _and_
> > > running the F0 0F bug-producing program (search for it on the 'net -
> > > it must be out there somewhere) to verify that the code still
> > > correctly handles that case.
> >
> > Something along the lines of:
> >
> > echo "unsigned long main=0xf00fc7c8;" > f00fbug.c ; make f00fbug
>
>Yes, that's what the (SGI) program uses:
>http://lwn.net/2001/0329/a/ltp-f00f.php3

That's not quite what they do. David's SGI equivalent would be:

echo "unsigned long main=0xc8c70ff0;" > f00fbug.c ; make f00fbug

i.e. remember that ia32 is little endian.

Thanks for the link.

Best regards,

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


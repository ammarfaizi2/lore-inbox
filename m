Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291157AbSBHAQ5>; Thu, 7 Feb 2002 19:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291163AbSBHAQr>; Thu, 7 Feb 2002 19:16:47 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:24010 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291157AbSBHAQj>; Thu, 7 Feb 2002 19:16:39 -0500
Message-Id: <5.1.0.14.2.20020208001423.00b0bc60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 08 Feb 2002 00:16:33 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] Fix floppy io ports reservation
Cc: dwguest@win.tue.nl (Guest section DW), linux-kernel@vger.kernel.org
In-Reply-To: <E16YwV5-0001ax-00@the-village.bc.nu>
In-Reply-To: <20020207202452.GA1527@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:54 07/02/02, Alan Cox wrote:
> > > I asked a friend to check and on his Windows 2000 system the port
> > > reservation was 0x3f2-0x3f5 + 0x3f7, i.e. it just excludes ports
> > > 0x3f0-0x3f1, which are NOT used anywhere in the driver anyway.
> >
> > ports 0x3f0 and 0x3f1 are used on certain PS/2 systems
> > and on some very old AT clones
>
>The driver must only reserve those ports on machines which needed them and
>when it needs them (which it never actually does). The ports are used for
>other superio related things on newer machines

Indeed, I couldn't find any code making use of the 0x3f0 and 0x3f1 ports, 
hence why I put forward my patch... If someone would like to prove me wrong 
here, please do so. (-:

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


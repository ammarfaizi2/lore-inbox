Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289121AbSANWbI>; Mon, 14 Jan 2002 17:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289108AbSANW2t>; Mon, 14 Jan 2002 17:28:49 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:33694 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S289096AbSANW2b>;
	Mon, 14 Jan 2002 17:28:31 -0500
Message-Id: <5.1.0.14.2.20020114222648.04ddccf0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Jan 2002 22:28:26 +0000
To: Ian Morgan <imorgan@webcon.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: ide.2.4.16.12102001 chokes on HPT366
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201141336480.2591-100000@light.webcon.net>
In-Reply-To: <Pine.LNX.4.10.10201132041350.18708-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you got the latest mobo BIOS and firmware for the HPT installed?

Some versions of your motherboard are known to be completely broken, even 
Windows users end up not using the onboard controller in some cases. This 
is not necessarilly a Linux IDE issue.

Best regards,

Anton

At 18:39 14/01/02, Ian Morgan wrote:
>On Sun, 13 Jan 2002, Andre Hedrick wrote:
>
> > Quantum Fireball LM30 -- stuff it in a quirk list in the top of the file
> > and see if that fixes it.
>
>--- hpt366.c~   Sun Jan 13 18:38:52 2002
>+++ hpt366.c    Mon Jan 14 01:24:55 2002
>@@ -82,7 +82,8 @@
>         "QUANTUM FIREBALLP KA6.4",
>         "QUANTUM FIREBALLP LM20.4",
>         "QUANTUM FIREBALLP LM20.5",
>-        NULL
>+       "QUANTUM FIREBALLP LM30",
>+       NULL
>  };
>
>  const char *bad_ata100_5[] = {
>
>
>... made no difference. Also tried ignoring the speed test and running the
>system as usual, but it consistently locks up during high disk IO.
>
>Regards,
>Ian Morgan
>--
>-------------------------------------------------------------------
>  Ian E. Morgan        Vice President & C.O.O.         Webcon, Inc.
>  imorgan@webcon.net         PGP: #2DA40D07          www.webcon.net
>-------------------------------------------------------------------
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287781AbSAXRFl>; Thu, 24 Jan 2002 12:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287786AbSAXRFb>; Thu, 24 Jan 2002 12:05:31 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:54501 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S287781AbSAXRFX>; Thu, 24 Jan 2002 12:05:23 -0500
Message-Id: <5.1.0.14.2.20020124170634.04b1ce70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 Jan 2002 17:07:23 +0000
To: Alexander Viro <viro@math.psu.edu>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.5.3-pre4 panics on boot )-:
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201240826320.21209-100000@weyl.math.psu.edu
 >
In-Reply-To: <5.1.0.14.2.20020124130949.02614370@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:28 24/01/02, Alexander Viro wrote:
>On Thu, 24 Jan 2002, Anton Altaparmakov wrote:
> > oops is below...
> >
> > Can't attach .config nor decode oops at the moment as the machine is now
> > dead (I am remote), I can reboot it remotely but LILO doesn't accept my
> > remote commands (even though I send a break signal it doesn't do anything,
> > just sits at prompt and after time out boots into -pre4 and dies - any
> > ideas?). )-:
> >
> > Is there a patch I can apply to fix this panic? Assuming one of the
> > scheduler ones. But which one?
>
>In arch/i386/kernel/smpboot.c find
>         global_irq_holder = 0;
>and s/0/NO_PROC_ID/

That worked a treat. Thanks!

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


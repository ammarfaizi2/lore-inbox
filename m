Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129640AbQKWIxE>; Thu, 23 Nov 2000 03:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129983AbQKWIwy>; Thu, 23 Nov 2000 03:52:54 -0500
Received: from 4dyn163.delft.casema.net ([195.96.105.163]:6666 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S129640AbQKWIwi>; Thu, 23 Nov 2000 03:52:38 -0500
Message-Id: <200011230822.JAA05965@cave.bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
In-Reply-To: <20001122234047.N2918@wire.cadcamlab.org> from Peter Samuelson at
 "Nov 22, 2000 11:40:47 pm"
To: Peter Samuelson <peter@cadcamlab.org>
Date: Thu, 23 Nov 2000 09:22:09 +0100 (MET)
CC: Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
From: R.E.Wolff@bitwizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:

> > +int loopback = 0;
> > +int fs_debug = 0;
> > +struct fs_dev *fs_boards = NULL;
 
> Aside from the 'static' issue already mentioned, these should be left
> uninitialized.  ('gcc -fassume-bss-zero' would be nice, but then again
> in userspace it rarely matters.)

Hi Peter, thanks for the feedback. 

Actually, I have an opinion on this matter: If the initialization
value doesn't really matter that much, I like leave out the
initialization, as you suggest.

However, if my code assumes that the compiler needs to initialize the
variable one way or another, I want to put in the initialization, even
if that means an "= 0;" which is already the default.

This is a form of documentation.

				Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

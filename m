Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129385AbQKVXfp>; Wed, 22 Nov 2000 18:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129470AbQKVXfg>; Wed, 22 Nov 2000 18:35:36 -0500
Received: from 13dyn94.delft.casema.net ([212.64.76.94]:41480 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S129385AbQKVXf1>; Wed, 22 Nov 2000 18:35:27 -0500
Message-Id: <200011222305.AAA30264@cave.bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
In-Reply-To: <20001122092356.B53983@sfgoth.com> from Mitchell Blank Jr at "Nov
 22, 2000 09:23:56 am"
To: Mitchell Blank Jr <mitch@sfgoth.com>
Date: Thu, 23 Nov 2000 00:05:18 +0100 (MET)
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

Mitchell Blank Jr wrote:
> First, I'd like to make a couple points about driver style that I'm trying
> to move towards with the ATM drivers.  You're free to take them or leave
> them, but I want to eventually move the tree in this direction.
>   * I don't like header files that define the registers of the chip - since
>     the header file is only included in the driver's .c file you might as
>     well just put the definitions there (unless, of course, there is good
>     reason to think that the registers will be used in multiple drivers -
>     unlikely in this case)  Having a seperate header file just serves to
>     hamper searching around the driver and cluttering the directory.

I disagree vehemently. 

The header file should have 'static things' that for example a
competing driver for the same chip could also use. The "driver
defines" should theoretically be in a separate file. This rarely
happens. 

For SX I have an "sxboard.h" with the defines that are in the HARDWARE
for the board. An "sxwindow.h" with the defines that belong with the
shared memory window that the firmware for the card defines, and an
sx.h which defines the parameters and datastructures of the driver.

This is how I like it.

>   * Please use the new PCI interface for new drivers
>   (i.e. MODULE_DEVICE_TABLE and all that)

It's on our todo list to learn how to do this. OK. We'll figure it out. 
 
> These should be defined static.

Agreed. Sorry about this. Lots of cases. 

Quick scan: I agree with you in almost all cases. Will do!

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

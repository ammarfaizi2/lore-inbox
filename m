Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136291AbREDLlc>; Fri, 4 May 2001 07:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136327AbREDLlX>; Fri, 4 May 2001 07:41:23 -0400
Received: from 13dyn74.delft.casema.net ([212.64.76.74]:34310 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S136249AbREDLlH>; Fri, 4 May 2001 07:41:07 -0400
Message-Id: <200105041140.NAA03391@cave.bitwizard.nl>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.4.21.0105031017460.30346-100000@penguin.transmeta.com>
 from Linus Torvalds at "May 3, 2001 10:21:04 am"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Fri, 4 May 2001 13:40:54 +0200 (MEST)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 3 May 2001, Alan Cox wrote:
> > Ditto for some CD based stuff. You burn the important binaries to the front
> > of the CD, then at boot dd 64Mb to /dev/null to prime the libraries and
> > avoid a lot of seeking during boot up from the CD-ROM.
> > 
> > However I could do that from an initrd before mounting
> 
> Ehh. Doing that would be extremely stupid, and would slow down your boot
> and nothing more.

Ehhh, Linus, Linearly reading my harddisk goes at 26Mb per second. By
analyzing my boot process I determine that 50M of my disk is used
during boot. I can then reshuffle my disk to have that 50M of data at
the beginning and reading all that into 50M of cache, I can save
thousands of 10ms seeks. Boot time would go from several tens of
seconds to 2 seconds worth of DISK IO plus several seconds of pure CPU
time.

This doesn't work if I don't have the memory to cache 50M of
disk-blocks.

Is this simply: Don't try this then? 

				Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBGTJN>; Wed, 7 Feb 2001 14:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbRBGTJD>; Wed, 7 Feb 2001 14:09:03 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:45572 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129047AbRBGTIm>; Wed, 7 Feb 2001 14:08:42 -0500
Date: Wed, 7 Feb 2001 13:03:41 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010207130341.C27700@vger.timpanogas.org>
In-Reply-To: <20010207111900.E27089@vger.timpanogas.org> <E14QZvc-00013n-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14QZvc-00013n-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 07, 2001 at 07:06:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 07:06:55PM +0000, Alan Cox wrote:
> > I looked into this, and discovered that the gcc 2.96 compiler turned my 
> > rep movsd code into a rep movsb (???) with some evil looking C++ style 
> 
> If its hand coded asm then gcc shouldnt have touched it. If its an implicit
> memcpy then gcc will generate inline code designed for main memory copying.
> 
> Do you have a small example chunk of code showing this ?
> 
> > They deviated by 30%, indicating that my MTRR write combining optimization
> > was not working properly in sci copy mode.  
> 
> That would explain the %age certainly. How it happened is the next question

I'll gen some code, and send to you.

:-)

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

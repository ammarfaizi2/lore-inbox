Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262199AbRETUMt>; Sun, 20 May 2001 16:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbRETUMk>; Sun, 20 May 2001 16:12:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43274 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262199AbRETUM1>; Sun, 20 May 2001 16:12:27 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 20 May 2001 21:07:03 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        rmk@arm.linux.org.uk (Russell King),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        matthew@wil.cx (Matthew Wilcox), alan@lxorguk.ukuu.org.uk (Alan Cox),
        clausen@gnu.org (Andrew Clausen), bcrl@redhat.com (Ben LaHaise),
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105201512450.8940-100000@weyl.math.psu.edu> from "Alexander Viro" at May 20, 2001 03:42:53 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151ZTj-0002pT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus, as much as I'd like to agree with you, you are hopeless optimist.
> 90% of drivers contain code written by stupid gits.

I think thats a very arrogant and very mistaken view of the problem. 90%
of the driver are written by people who are

	-	Copying from other drivers
	-	Using the existing API's to make their job easy
	-	Working to timescales
	-	Just want it to work

So if you take ioctl away from them they will implement ioctl emulation by
writing ioctl structs to an fd.

If you want to make these things work well you have to provide a good working
infrastructure. You don't change anything (except the maintainer) by causing
pain. Instead you provide the mechanisms - the generic parsing code so that
people don't screw up on procfs parsing - the generic ioctl alternatives etc.

Ditto with the major numbers. You win that battle by getting enough people to
believe it is the right answer that they write the nice code for managing 
resources and naming assignment - which is already beginning to occur. Then
even if I'm still maintaining a major number list in 2 years nobody can quite
remember why, and people are heard murmering 'You should have tried Linux two
years ago, you had to actually make device files yourself sometimes'

Alan


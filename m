Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272407AbRH3TAt>; Thu, 30 Aug 2001 15:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272409AbRH3TAk>; Thu, 30 Aug 2001 15:00:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17682 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272407AbRH3TAZ>; Thu, 30 Aug 2001 15:00:25 -0400
Subject: Re: [PATCH] blkgetsize64 ioctl
To: tytso@mit.edu (Theodore Tso)
Date: Thu, 30 Aug 2001 20:03:25 +0100 (BST)
Cc: bcrl@redhat.com (Ben LaHaise), michael_e_brown@dell.com (Michael E Brown),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010830145155.A3114@thunk.org> from "Theodore Tso" at Aug 30, 2001 02:51:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cX66-0001cu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 30, 2001 at 01:12:07PM -0400, Ben LaHaise wrote:
> > No, that's not what's got me miffed.  What is a problem here is that an
> > obvious next to use ioctl number in a *CORE* kernel api was used without
> > reserving it.  AND PEOPLE SHIPPED IT!  I for one don't go about shipping
> > new ABIs without reserving at least a placeholder for it in the main
> > kernel (or stating that the code is not bearing a fixed ABI).  If the
> > ioctl # was in the main kernel, this mess would never have happened even
> > with the accidental shipping of the patch in e2fsprogs.  
> 
> ... and for my part, I included the patch in e2fsprogs because Ben
> sent me the patch, saying that people would want to test it, and I
> assumed he had already reserved the ioctl in the kernel.  I should
> have checked first....

Follow the rule I use with Linus - never send proposed changes you dont
mean to be merged in a compilable form

On this subject I think it would be good to get the security() syscall
allocated now that folks are using the LSM framework for real stuff - even
the NSA stuff

Alan

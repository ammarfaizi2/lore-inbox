Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132388AbQKKUSt>; Sat, 11 Nov 2000 15:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132360AbQKKUS3>; Sat, 11 Nov 2000 15:18:29 -0500
Received: from slc602.modem.xmission.com ([166.70.7.94]:24071 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132388AbQKKUSZ>; Sat, 11 Nov 2000 15:18:25 -0500
To: Wakko Warner <wakko@animx.eu.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001109113524.C14133@animx.eu.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2000 13:05:18 -0700
In-Reply-To: Wakko Warner's message of "Thu, 9 Nov 2000 11:35:24 -0500"
Message-ID: <m1g0kycm0x.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner <wakko@animx.eu.org> writes:

> > I have recently developed a patch that allows linux to directly boot
> > into another linux kernel.  With the code freeze it appears
> > inappropriate to submit it at this time. 
> > 
> > Linus in principal do you have any trouble with this kind of
> > functionality? 
> > 
> > The immediate applications of this code, are:
> > - Clusters can network can network boot over arbitrary network
> >   interfaces, and the network driver only needs to be written and
> >   maintained in one place.
> > - Multiplatform boot loaders can be written.
> > - The Linux kernel can be included in a boot ROM and you can still
> >   boot other linux kernels.
> > - Kernel developers can have a fast interface for booting into a
> >   development kernel.
> > 
> > The interface is designed to be simple and inflexible yet very
> > powerful.  To that end the code just takes an elf binary, and a
> > command line.  The started image also takes an environment generated
> > by the kernel of all of the unprobeable hardware details.
> 
> Isn't this what milo does on alpha?

Similar milo uses kernel drivers in it's own framework.  
This has proved to be a major maintenance problem.  Milo is nearly
a kernel fork.  

The design is for the long term to get this incorporated into the
kernel, and even if not a small kernel patch should be easier to
maintain that a harness for calling kernel drivers.

Eric


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

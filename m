Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318721AbSICHax>; Tue, 3 Sep 2002 03:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318722AbSICHax>; Tue, 3 Sep 2002 03:30:53 -0400
Received: from codepoet.org ([166.70.99.138]:6609 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318721AbSICHax>;
	Tue, 3 Sep 2002 03:30:53 -0400
Date: Tue, 3 Sep 2002 01:35:25 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, andre@linux-ide.org
Subject: Re: Linux 2.4.18: short dd read from IDE cdrom
Message-ID: <20020903073525.GA13386@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jonathan Woithe <jwoithe@physics.adelaide.edu.au>,
	linux-kernel@vger.kernel.org, axboe@suse.de, andre@linux-ide.org
References: <200209020527.g825RHd07114@sprite.physics.adelaide.edu.au> <200209030719.g837JCJ24173@sprite.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209030719.g837JCJ24173@sprite.physics.adelaide.edu.au>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 03, 2002 at 04:49:12PM +0930, Jonathan Woithe wrote:
> Hi all
> 
> Yesterday I reported a problem to lkml I observed with `dd' and ide cds:
> > For a number of years now I have duplicated cds using
> >   dd if=/dev/cdrom of=foo.iso
> >   cdrecord ... foo.iso
> > :
> > Today I tried the same trick under 2.4.18 and struck a problem: the kernel
> > would not read the complete CD image. ...
> 
> After further testing, it seems that turning off dma using "hdparm -d 0
> /dev/hdc" allows things to work as expected - the full disk can be read and
> the resulting image is intact.  It appears therefore that the problem may

Interesting.  When DMA is enabled does running 
    blockdev --setra 0 /dev/cdrom
make any difference?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

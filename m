Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSGLTkp>; Fri, 12 Jul 2002 15:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSGLTko>; Fri, 12 Jul 2002 15:40:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16121 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316798AbSGLTkn>; Fri, 12 Jul 2002 15:40:43 -0400
Subject: Re: IDE/ATAPI in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207121937.g6CJb1aq018419@burner.fokus.gmd.de>
References: <200207121937.g6CJb1aq018419@burner.fokus.gmd.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jul 2002 21:52:06 +0100
Message-Id: <1026507126.9958.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-12 at 20:37, Joerg Schilling wrote:
> >o       Many ide floppy devices can do ATAPI but get it horribly wrong
> 
> Describe the problems.

Go read the source code, do your own homework

> Depending on the kernel version, this either causes a system panic or
> just does not work at all. As all ATAPI CD-writers and CD-rom drives
> have a fallback to ATA commands, nobody who does not like to use a writer
> will ever notice the problem. They simply access the CD-ROM as read only
> ATA disk. If ide-cd would have been banned this bug would have been fixed years 
> ago.

Which wouldnt work, because thats not what the CD interface part is
about

> >For disk it gets much easier. Linus has already said he wants a single
> >'disk' device, which once we get 32bit dev_t will be nice. With that we
> >can finally turn aacraid, megaraid and other 'fake scsi' devices back to
> >raw block devices without breaking compatibility assumptions, and get more
> >throughput.
> 
> 
> Sorry, this has nothing to do with dev_t

It has a huge amount to do with dev_t. It should be immediately obvious
why dev_t is a critical factor in getting that interface working in a
sane fashion.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSGUXtZ>; Sun, 21 Jul 2002 19:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSGUXtZ>; Sun, 21 Jul 2002 19:49:25 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3064 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315420AbSGUXtX>; Sun, 21 Jul 2002 19:49:23 -0400
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
In-Reply-To: <Pine.LNX.4.44.0207220143520.4084-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0207220143520.4084-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 02:04:01 +0100
Message-Id: <1027299841.16818.124.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 00:44, Ingo Molnar wrote:
> 
> On Mon, 22 Jul 2002, Russell King wrote:
> 
> > Actually its to cover the case where you have a floppy drive, and you've
> > booted the kernel from a floppy disk, and the kernel doesn't have the
> > floppy driver built in.  It turns the floppy drive off, cause there's
> > nothing else to do that.
> 
> this should then be done by the floppy boot code?

Most definitely. On legacy free boxes there may not even be a floppy
controller present, and on non x86 your guess is as good as mine at
where the fdc lives.

Alan


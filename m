Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSKJQhu>; Sun, 10 Nov 2002 11:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSKJQhu>; Sun, 10 Nov 2002 11:37:50 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:57248 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264938AbSKJQhu>; Sun, 10 Nov 2002 11:37:50 -0500
Subject: Re: BOGUS: megaraid changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211101632.gAAGWln11508@localhost.localdomain>
References: <200211101632.gAAGWln11508@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Nov 2002 17:08:49 +0000
Message-Id: <1036948129.1005.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-10 at 16:32, J.E.J. Bottomley wrote:
> alan@lxorguk.ukuu.org.uk said:
> > I dont think panic() is needed bug a loud printk and maybe an error
> > return from scsi_register() would do the trick. We do however have a
> > couple of drivers where "pray, the firmware does all the work" is the
> > right answer, but they really should be setting their own handler that
> > delays rather than aborting/resetting/kicking offline 
> 
> How about this?  It doesn't panic, just refuses to attach the driver (although 
> this will still eventually cause a panic if your root fs is on it).

Looks a good starting point so that people can use the drivers but do
get warned


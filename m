Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVAQOaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVAQOaF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 09:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVAQOaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 09:30:05 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:41694 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262805AbVAQO3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 09:29:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16875.52184.169399.632936@xf14.local>
Date: Mon, 17 Jan 2005 15:29:44 +0100
From: Egbert Eich <eich@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Egbert Eich <eich@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vgacon fixes to help font restauration in X11
In-Reply-To: alan@lxorguk.ukuu.org.uk wrote on Monday, 17 January 2005 at 12:23:21 +0000 
References: <16867.58009.828782.164427@xf14.fra.suse.de>
	<1105745463.9839.55.camel@localhost.localdomain>
	<16875.32871.47983.655764@xf14.local>
	<1105961582.12709.51.camel@localhost.localdomain>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Llu, 2005-01-17 at 09:07, Egbert Eich wrote:
 > > Can you point me to these reports?
 > > I tested with a couple chipsets here and didn't find any problems.
 > 
 > I'll take a dig. The ones I've got are for 2.4 so relate to old code.
 > 
 > > We could check for the kernel version. This could be done during build
 > > time - assuming we don't ship generic binaries or during run time if we
 > > want to provide binaries that work everywhere.
 > > In reality the former would be sufficient for a lot of cases - especially
 > > for vendor supplied binaries.
 > 
 > The former would be a disaster for Fedora for example - we ship
 > 'current' kernels and having kernel upgrades require a new X11 won't
 > endear users . A runtime check on version might work I was wondering if

No, it would rather be the other way around. A new version of X would
require a certain version of the kernel - unless you plan to drop the 
feature again.
This however will not be necessary until 6.9/7 (however it will be named)
comes out.
I can implement both ways. Since the new font code lives in the OS dependent
part this should not be a problem at all.
The only disadvantage may be that I may not be able to turn off the old
font code in the generic vgaHW stuff.

 > it would be better to have an actual interface that said "do/do not
 > restore the extra bits in kernel".
 > 
 > That also avoids any suprises and regressions ?

I used to have a patch like that. But kernel people I've talked to told
me that it would be preferrable not to change the API if not necessary.

In my opinion it is not. The changes only affect cases where a new font
gets written or restored.

 > > Anyway, would my patch be acceptable for the kernel?
 > 
 > I'm not video maintainer but other than the detection question it looks
 > sensible to me.
 > 

OK, sounds promising. The changed Xserver pieces are in HEAD of the 
X.Org tree. I'll see that I make the necessary adjustments to have
a soft detection if you can give me a version number of the kernel
which will have the new features.

Egbert.


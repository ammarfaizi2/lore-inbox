Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268852AbRG0NkQ>; Fri, 27 Jul 2001 09:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268857AbRG0NkI>; Fri, 27 Jul 2001 09:40:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15879 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268852AbRG0NkD>; Fri, 27 Jul 2001 09:40:03 -0400
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: bvermeul@devel.blackstar.nl
Date: Fri, 27 Jul 2001 14:39:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), reiser@namesys.com (Hans Reiser),
        J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw), haiquy@yahoo.com (Steve Kieu),
        samuelt@cervantes.dabney.caltech.edu (Sam Thompson),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <Pine.LNX.4.33.0107271533330.10602-100000@devel.blackstar.nl> from "bvermeul@devel.blackstar.nl" at Jul 27, 2001 03:38:24 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Q7q5-0005e9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > Putting a sync just before the insmod when developing new drivers is a good
> > idea btw
> 
> I've been doing that most of the time. But I sometimes forget that.
> But as I said, it's not something I expected from a journalled filesystem.

You misunderstand journalling then

A journalling file system can offer different levels of guarantee. With 
metadata only journalling you don't take any real performance hit but your
file system is always consistent on reboot (consistent as in fsck would pass
it) but it makes no guarantee that data blocks got written.

Full data journalling will give you what you expect but at a performance hit
for many applications.

Alan


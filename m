Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268358AbRGZRNB>; Thu, 26 Jul 2001 13:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268371AbRGZRMv>; Thu, 26 Jul 2001 13:12:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23311 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268358AbRGZRMl>; Thu, 26 Jul 2001 13:12:41 -0400
Subject: Re: Validating Pointers
To: tpepper@vato.org
Date: Thu, 26 Jul 2001 18:12:57 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010726100955.B18938@cb.vato.org> from "tpepper@vato.org" at Jul 26, 2001 10:09:55 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Pogz-00048x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Should the i386 access_ok() fail when checking a copy to/from userspace
> from/to a static in a driver module?  The __copy_to|from_user work fine
> and copy_to|from_user fail, but I guess that doesn't mean access_ok()
> is the culprit.  I don't know intel assembly and the platforms for
> which I do get the assembly don't do much in access_ok() so there's no
> comparing...but I'd have thought they'd be more concerned with the user
> address location than the kernel one.

You can't pass kernel address as if they were userspace. It might happen to
sometimes work on some architectures. Take a look at the set_fs() stuff

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWHQNSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWHQNSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHQNSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:18:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48321 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932234AbWHQNSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:18:31 -0400
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: 7eggert@gmx.de
Cc: Arjan van de Ven <arjan@infradead.org>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Dirk <noisyb@gmx.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1GDgyZ-0000jV-MV@be1.lrz>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it>
	 <6KyCQ-1w7-25@gated-at.bofh.it>  <E1GDgyZ-0000jV-MV@be1.lrz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 14:39:11 +0100
Message-Id: <1155821951.15195.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 14:27 +0200, ysgrifennodd Bodo Eggert:
> HAL using O_EXCL will randomly prevent burning/mounting/etc by causing a
> race condition, so it can't do that. HAL not using O_EXCL will OTOH succeed

man 3 sleep
man 2 flock

or in the GUI world I'm firmly assured that the sun shines out of the
arse of dbus for intra desktop communication.

Lots of solutions.

> Maybe it's possible to cache the result and thereby prevent repeated
> opening from disturbing the burning process.

We could certainly add an ioctl for this in the new libata layer. We
couldn't automate it as with pass through commands the kernel doesn't
really know what kind of exclusivity is needed and when.

Not sure its actually useful but its doable.

Alan

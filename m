Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbRE2Tyc>; Tue, 29 May 2001 15:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRE2TyW>; Tue, 29 May 2001 15:54:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47372 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261645AbRE2TyR>; Tue, 29 May 2001 15:54:17 -0400
Subject: Re: select() - Linux vs. BSD
To: jcwren@jcwren.com
Date: Tue, 29 May 2001 20:51:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGKEIICHAA.jcwren@jcwren.com> from "John Chris Wren" at May 29, 2001 11:55:24 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154pWn-0004nN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	In BSD, select() states that when a time out occurs, the bits passed to
> select will not be altered.  In Linux, which claims BSD compliancy for this

Nope. BSD manual pages (the authentic ones anyway) say that the timeout value
may well be written back but that this was a future enhancement and that users
shoulsnt rely on the value being unchanged.

> in the man page (but does not state either way what will happen to the
> bits), zeros the users bit masks when a timeout occurs.  I have written a
> test case, and run on both systems; BSD behaves as stated, Linux does not
> act like BSD.
> 
> 	Should the man pages be changed to reflect reality, or select() fixed to
> act like BSD?

BSD should stop changing its mind if its changed its man pages


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262729AbREOKlC>; Tue, 15 May 2001 06:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbREOKkw>; Tue, 15 May 2001 06:40:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8207 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262729AbREOKkt>; Tue, 15 May 2001 06:40:49 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 15 May 2001 11:36:30 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.GSO.4.21.0105150556120.21081-100000@weyl.math.psu.edu> from "Alexander Viro" at May 15, 2001 06:12:52 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zcBq-0002Ku-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cost of adding IOCTL_REWIND_TAPE - two words in each tape driver. That
> alone kills a bunch of crap in userland and makes _both_ sides more
> maintainable.

A lot lot more than that. There are some cases where what you are saying is
true and we have duplication. The worst culprit was the cd layer and that
has been cleaned up for a while now.

In most of the other cases it varies what is done in drive firmware or in
userspace by the app. Reimplementing half of the drive firmware in kernel
space not user space does not appeal

Where it just normalising ioctl numbers I'd agree 100%



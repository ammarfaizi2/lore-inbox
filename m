Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269292AbRHGTD2>; Tue, 7 Aug 2001 15:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269312AbRHGTDH>; Tue, 7 Aug 2001 15:03:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32783 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269308AbRHGTDF>; Tue, 7 Aug 2001 15:03:05 -0400
Subject: Re: [PATCH] one of $BIGNUM devfs races
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Tue, 7 Aug 2001 20:04:34 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Richard Gooch" at Aug 07, 2001 12:55:47 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UC9a-0003kt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Very interesting. pwd should be using getcwd(2), which doesn't
> > give a damn for inode numbers. If you have seriously old pwd binary
> > that tries to track the thing down to root by hands - yes, it doesn't
> > work.
> 
> Hm. strace suggests my pwd is walking up the path. But WTF would it
> break? 2.4.7 was fine. What did I break?

Sounds like you are using libc5. The old style pwd should be reliable but
its much slower and can't see across protected directory paths

Alan

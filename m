Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267987AbRHBAPR>; Wed, 1 Aug 2001 20:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267973AbRHBAPG>; Wed, 1 Aug 2001 20:15:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45324 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267992AbRHBAOz>; Wed, 1 Aug 2001 20:14:55 -0400
Subject: Re: [PATCH] vxfs fix
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 2 Aug 2001 01:15:13 +0100 (BST)
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, hch@caldera.de,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108011522590.21247-100000@penguin.transmeta.com> from "Linus Torvalds" at Aug 01, 2001 03:29:58 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15S68v-00083w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think V7 has a magic number at all. But checking that the size and
> nr-of-inodes fields make sense, together with verifying that the root
> inode really is a directory with (size % 512) == 0, and possibly verifying
> things like "if the root directory is not large enough to have a
> doubly/triply indirect block, then that doubly/triply indirect blocknumber
> had better be zero"  would catch 99.9% of everything.

Alternatively pass a flag to the mount command saying "this is a guesswork
special" then V7 fs can just return 'not me'

Alan

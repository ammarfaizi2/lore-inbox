Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314650AbSEBQ4p>; Thu, 2 May 2002 12:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314653AbSEBQ4o>; Thu, 2 May 2002 12:56:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28429 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314650AbSEBQ4n>; Thu, 2 May 2002 12:56:43 -0400
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 2 May 2002 18:15:17 +0100 (BST)
Cc: rgooch@ras.ucalgary.ca (Richard Gooch), arjanv@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CD15CFA.1090208@evision-ventures.com> from "Martin Dalecki" at May 02, 2002 05:36:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173KAn-0004No-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The main problem with mod-versions is the simple fact
> that policy doesn't belong in to the kernel it belongs
> in the user space. And mod-version is *just policy*.

Nope. modversions are information about the ABI/API and objects referenced
directly or indirectly from them.  The policy is entirely in modutils.
Modutils has the power to say "well that looks kind of the same I'll bind
that symbol name".

Kernel -> "Here is a helpful set of ABI compatibility hashes"
Modutils -> "This symbol doesnt match, what do we want to do about it. Lets
	     fail". It could equally pick something looking similar.

> It just DOES NOT BELONG in to the kernel-space.

People who start using capital letters always seem to have emotional rather
than logical reasons for their argument.

Alan
--
"Intel sued Cyrix five times and they never won. Intel they just love lawsuits"
		--  Wen Chi Chen, Via's CEO


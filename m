Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSFLJXy>; Wed, 12 Jun 2002 05:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSFLJXy>; Wed, 12 Jun 2002 05:23:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21509 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316390AbSFLJXx>; Wed, 12 Jun 2002 05:23:53 -0400
Subject: Re: [PATCH] fs/locks.c: Fix posix locking for threaded tasks
To: willy@debian.org (Matthew Wilcox)
Date: Wed, 12 Jun 2002 10:40:07 +0100 (BST)
Cc: torvald@transmeta.com (Linus Torvalds),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        sdesai@austin.ibm.com (Saurabh Desai),
        sfr@canb.auug.org.au (Stephen Rothwell), linux-kernel@vger.kernel.org
In-Reply-To: <20020610034843.W27186@parcelfarce.linux.theplanet.co.uk> from "Matthew Wilcox" at Jun 10, 2002 03:48:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I4bn-0007Rn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SUS v3 does not offer any enlightenment.  But it seems reasonable that
> processes which share a files_struct should share locks.  After all,
> if one process closes the fd, they'll remove locks belonging to the
> other process.
> 
> Here's a patch generated against 2.4; it also applies to 2.5.
> Please apply.

This seems horribly inappropriate for 2.4 as it may break apps

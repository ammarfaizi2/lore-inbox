Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285236AbRLXS4P>; Mon, 24 Dec 2001 13:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285246AbRLXS4F>; Mon, 24 Dec 2001 13:56:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30725 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285236AbRLXSz7>; Mon, 24 Dec 2001 13:55:59 -0500
Subject: Re: [patch] Assigning syscall numbers for testing
To: dledford@redhat.com (Doug Ledford)
Date: Mon, 24 Dec 2001 19:05:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kaos@ocs.com.au (Keith Owens),
        bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org
In-Reply-To: <3C2770FE.80403@redhat.com> from "Doug Ledford" at Dec 24, 2001 01:16:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16IaPj-0004u4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it.  However, I think it needs to be allocated *regardless* of whether Linus 
> takes the patch into his kernel.  Even if the patch is simply used outside 
> Linus's kernel, it still needs the allocation to truly be safe.

Negative numbers are safe until Linus has 2^31 syscalls, at which point
quite frankly we would have a few other problems including the fact that
the syscall table won't fit in kernel mapped memory.

I'm sure we could get Linus to agree not to use negative numbers out of
spite.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWH3VJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWH3VJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWH3VJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:09:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59349 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751589AbWH3VJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:09:50 -0400
Subject: Re: [PATCH][RFC] exception processing in early boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <w@1wt.eu>
Cc: Andi Kleen <ak@suse.de>, pageexec@freemail.hu, davej@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060830200354.GA496@1wt.eu>
References: <20060830063932.GB289@1wt.eu> <200608302026.05968.ak@suse.de>
	 <20060830190125.GA21041@1wt.eu> <200608302136.54624.ak@suse.de>
	 <20060830200354.GA496@1wt.eu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Aug 2006 22:31:18 +0100
Message-Id: <1156973479.6271.214.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-30 am 22:03 +0200, ysgrifennodd Willy Tarreau:
> So, to conclude, with or without the bug, "hlt;jmp $" will halt the
> CPU as we expect it to. Therefore, I'd like you to restore it in
> the patch.

Having had a dig I would concur that we should add the "hlt" back. The
cases I can find are 386/486 "hangs if hlt executed" bugs, mostly
unresolved/chipset problems and a "hlt during IDE DMA hangs the box" bug
we work around on the Cyrix CS5510.

That said for a PIV at least "hlt" really makes little difference to the
power burn


Return-Path: <linux-kernel-owner+w=401wt.eu-S965164AbXAGVEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbXAGVEK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 16:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbXAGVEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 16:04:09 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:50510 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965164AbXAGVEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 16:04:08 -0500
To: dmitry.torokhov@gmail.com
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kaber@trash.net
Subject: Re: Linux 2.6.20-rc4
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<m37ivyr1v6.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 07 Jan 2007 22:04:02 +0100
In-Reply-To: <m37ivyr1v6.fsf@telia.com>
Message-ID: <m33b6mr1kt.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Patrick McHardy (2):
> >       [NETFILTER]: New connection tracking is not EXPERIMENTAL anymore
> 
> I get kernel panics when doing large ethernet transfers. A loop doing

I also see an annoying side effect of this bug. When the panic
happens, the caps lock LED starts to blink, and the kernel prints this
on the console once every second (or more often, don't know exactly):

	printk(KERN_WARNING "atkbd.c: Spurious %s on %s. "
	       "Some program might be trying access hardware directly.\n",
	       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);

This makes the actual crash information disappear before you have a
chance to read it.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbUJaEL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUJaEL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 00:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUJaEL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 00:11:28 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:39458 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261495AbUJaELZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 00:11:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.58.0410302005270.28839@ppc970.osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 30 Oct 2004 21:11:24 -0700
In-Reply-To: <Pine.LNX.4.58.0410302005270.28839@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 30 Oct 2004 20:20:53 -0700 (PDT)")
Message-ID: <52d5yzwmqb.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: Sparse "context" checking..
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 31 Oct 2004 04:11:24.0688 (UTC) FILETIME=[AFB2B900:01C4BEFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Linus> In particular, this is designed for doing things like
    Linus> matching up a "lock" with the pairing "unlock", and right
    Linus> now that's exactly what the code does: it makes each
    Linus> spinlock count as "+1" in the context, and each spinunlock
    Linus> count as "-1", and then hopefully it should all add up.

Do you have a plan for how to handle functions like spin_trylock()?  I
notice in the current tree you just didn't annotate spin_trylock().

Thanks,
  Roland

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWE1Qbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWE1Qbh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWE1Qbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:31:36 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:60620 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750793AbWE1Qbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:31:36 -0400
Date: Mon, 29 May 2006 01:32:26 +0900 (JST)
Message-Id: <20060529.013226.108739444.anemo@mba.ocn.ne.jp>
To: rdunlap@xenotime.net
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: gcc 4.1.1 issues with 2.6.17-rc5
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060527223945.05cd5b5b.rdunlap@xenotime.net>
References: <200605281255.49821.kernel@kolivas.org>
	<200605281521.20876.kernel@kolivas.org>
	<20060527223945.05cd5b5b.rdunlap@xenotime.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 May 2006 22:39:45 -0700, "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> > and a missed one:
> > WARNING: drivers/usb/storage/usb-storage.o - Section mismatch: reference 
> > to .exit.text: from .smp_locks after '' (at offset 0x40)
> 
> Yep, Jesper posted that one.
> I also see it in ieee1394.o.
> 
> So where does the .smp_locks section come from?
> Is this just a section checker bug/issue?

The .smp_locks section comes from LOCK_PREFIX on x86.  I think the
warnings was not shown previously just because the modpost did not
check SHT_REL sections.

Maybe we should fix the modpost to ignore it, but I'm not sure.  Is it
really safe to ignore?  I'm not a x86 expert ...

---
Atsushi Nemoto

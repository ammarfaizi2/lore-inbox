Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUENThw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUENThw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUENThw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:37:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32694 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262329AbUENThu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:37:50 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] H8/300 IDE support update
Date: Fri, 14 May 2004 21:38:55 +0200
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m24qqj9o9j.wl%ysato@users.sourceforge.jp> <200405141507.31492.bzolnier@elka.pw.edu.pl> <m23c62aof8.wl%ysato@users.sourceforge.jp>
In-Reply-To: <m23c62aof8.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405142138.55928.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 of May 2004 19:50, Yoshinori Sato wrote:
> At Fri, 14 May 2004 15:07:31 +0200,
>
> Bartlomiej Zolnierkiewicz wrote:
> > On Friday 14 of May 2004 14:39, Yoshinori Sato wrote:
> > > - IDE support update.
> > > - unused memory hole delete.
> >
> > Yoshinori, this patch doesn't apply to vanilla 2.6.6 / 2.6.6-bk1.
> >
> > And once again: please do not use ide_default_{irq,io_base}()
> > and ide_init_hwif_ports() in new IDE code.
>
> Because an address does not continue,
> Cannot set a right address in ide_std_init_ports.

You don't need to use ide_std_init_ports() - it is just a helper
and you shouldn't need ide_init_hwif_ports() et all!

Just add driver to drivers/ide/h8300/ and describe what changes
(not hacks) to the core IDE code you need to make it work (if any).

Cheers.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264908AbUFCQCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264908AbUFCQCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUFCP6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:58:49 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:59658 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S264908AbUFCPzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:55:53 -0400
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Frediano Ziglio" <freddyz77@tin.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
References: <40BA2213.1090209@pobox.com> <20040603103907.GV23408@apps.cwi.nl>
	<s5gaczkwvg8.fsf@patl=users.sf.net>
	<200406031732.10919.bzolnier@elka.pw.edu.pl>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5g1xkwveuu.fsf@patl=users.sf.net>
Date: 03 Jun 2004 11:55:51 -0400
In-Reply-To: <200406031732.10919.bzolnier@elka.pw.edu.pl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:

> > So one approach is to leave HDIO_GETGEO alone, and to have a
> > userspace gadget run early to "fix" the kernel's notion of the
> > geometry.  This would avoid the need to rewrite every partitioning
> > tool.
> 
> This is a bandaid not a solution and it is just silly (you push
> some values into kernel just to read them back by user-space).

It might be silly if we were designing all this from scratch.  But in
the context of current practice and current tools, it is not so
obvious, at least to me.  HDIO_GETGEO has existed forever, and it is
used by all current partitioning tools (and some non-partitioning
tools, such as dosemu).

> Also what if kernel is compiled with CONFIG_PROC_FS=n
> or if I decide to pull out /proc/ide/hdx/settings one day?

Then my code will break.  :-)

I have no theoretical objection to eliminating HDIO_GETGEO and
/proc/ide/hdx/settings.  But it would be polite to have a nice long
deprecation period because these interfaces ARE in use.  It is the
only way to use Parted for my application, for example.

 - Pat

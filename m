Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130376AbRALCfA>; Thu, 11 Jan 2001 21:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131033AbRALCeu>; Thu, 11 Jan 2001 21:34:50 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:8099 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S130376AbRALCel>; Thu, 11 Jan 2001 21:34:41 -0500
Message-Id: <200101120327.f0C3Rxc02512@513.holly-springs.nc.us>
Subject: O_NONBLOCK, read(), select(), NFS, Ext2, etc.
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 11 Jan 2001 21:34:08 -0500
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The man pages for open, read and write say that if a file is opened
using the O_NONBLOCK flag, then read() and write() will always return
immediately and not block the calling process. This does not appear to
be true; but perhaps I am doing something wrong. If I open() a file (on
2.2.18) from a floppy or NFS mount (to test in a slow environment) with
O_NONBLOCK|O_RDONLY, read() will still block. If I try to select() on
the file descriptor, select() always returns 0.

Is there a way to make open(), read() and write() live up to their
manpages?

-M

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

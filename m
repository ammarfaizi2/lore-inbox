Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130357AbRALJjv>; Fri, 12 Jan 2001 04:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130359AbRALJjb>; Fri, 12 Jan 2001 04:39:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62480 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130282AbRALJjQ>; Fri, 12 Jan 2001 04:39:16 -0500
Subject: Re: O_NONBLOCK, read(), select(), NFS, Ext2, etc.
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Fri, 12 Jan 2001 09:40:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200101120327.f0C3Rxc02512@513.holly-springs.nc.us> from "Michael Rothwell" at Jan 11, 2001 09:34:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14H0hc-00043X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> using the O_NONBLOCK flag, then read() and write() will always return
> immediately and not block the calling process. This does not appear to
> be true; but perhaps I am doing something wrong. If I open() a file (on
> 2.2.18) from a floppy or NFS mount (to test in a slow environment) with
> O_NONBLOCK|O_RDONLY, read() will still block. If I try to select() on
> the file descriptor, select() always returns 0.

The definition of immediate is not 'instant'. Otherwise no I/O system would
ever return anything but -EWOULDBLOCK. Its that it won't wait when there is
no data pending. On a floppy there is always data pending

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

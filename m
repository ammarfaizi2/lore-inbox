Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129557AbQKYVdH>; Sat, 25 Nov 2000 16:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129673AbQKYVc6>; Sat, 25 Nov 2000 16:32:58 -0500
Received: from hera.cwi.nl ([192.16.191.1]:43763 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129557AbQKYVcw>;
        Sat, 25 Nov 2000 16:32:52 -0500
Date: Sat, 25 Nov 2000 22:02:43 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: Eugene Crosser <crosser@average.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: "_isofs_bmap: block < 0"
Message-ID: <20001125220243.A6919@veritas.com>
In-Reply-To: <8vd0cb$5a0$1@pccross.average.org> <Pine.LNX.4.21.0011251818550.9351-100000@sjoerd.sjoerdnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011251818550.9351-100000@sjoerd.sjoerdnet>; from iafilius@xs4all.nl on Sat, Nov 25, 2000 at 06:20:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 06:20:56PM +0100, Arjan Filius wrote:

> Nov 25 18:16:05 sjoerd kernel: _isofs_bmap: block < 0

Understood and solved. For the whole story read linux-kernel.
To fix just this, remove the two lines

	if (filp->f_pos >= inode->i_size)
		return 0;

from linux/fs/isofs/dir.c around line 119.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130579AbRAFP5i>; Sat, 6 Jan 2001 10:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129857AbRAFP51>; Sat, 6 Jan 2001 10:57:27 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20235 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131227AbRAFP5O>; Sat, 6 Jan 2001 10:57:14 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: cw@f00f.org (Chris Wedgwood)
Date: Sat, 6 Jan 2001 15:58:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <20010107045346.B696@metastasis.f00f.org> from "Chris Wedgwood" at Jan 07, 2001 04:53:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Evjb-0001Dk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which filesystems have limits other than 2^31 bytes?

Ext2 handles large files almost properly. (properly on 2.2 + patches)
NFSv3 handles large files but might be missing the O_LARGEFILE check.
I believe reiserfs went to at least 4Gig.

> O_LARGEFILE at present (well, their is perhaps good reason for this
> as it is one of the fre that supports multiGB files) whereas I think
> this check should be done in the VFS.

Possibly

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbQKBXzm>; Thu, 2 Nov 2000 18:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQKBXzc>; Thu, 2 Nov 2000 18:55:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46932 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129307AbQKBXzY>; Thu, 2 Nov 2000 18:55:24 -0500
Subject: Re: select() bug
To: pmarquis@iname.com (Paul Marquis)
Date: Thu, 2 Nov 2000 23:55:52 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3A01FC44.8A43FE8B@iname.com> from "Paul Marquis" at Nov 02, 2000 06:44:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rUD4-00026g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Does this make sense with devices with small kernel buffers?  From
> my experimentation, pipes on Linux have a 4K buffer and tend to be
> read and written very quickly. 

It makes sense for all things I suspect

> - If I'm correct that pipes have a 4K kernel buffer, then writing 1
> byte shouldn't cause this situation, as the buffer is well more than
> half empty.  Is this still a bug?

The pipe code uses totally full/empty. Im not sure why that was chosen

> Semantic issues aside, since Apache does the test I mentionned earlier
> to determine child status and since it could be misled, should this
> feature be turned off?

Or made smarter yes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

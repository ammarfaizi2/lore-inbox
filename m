Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130885AbQKXOfK>; Fri, 24 Nov 2000 09:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132397AbQKXOfB>; Fri, 24 Nov 2000 09:35:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50990 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S130885AbQKXOeo>; Fri, 24 Nov 2000 09:34:44 -0500
Subject: Re: OOPS on bringing down ppp
To: andrewm@uow.edu.au (Andrew Morton)
Date: Fri, 24 Nov 2000 14:04:53 +0000 (GMT)
Cc: mark.uzumati@virgin.net (Mark Ellis), linux-kernel@vger.kernel.org,
        viro@math.psu.edu (Alexander Viro)
In-Reply-To: <3A1E5EFC.16E7625A@uow.edu.au> from "Andrew Morton" at Nov 24, 2000 11:28:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13zJTD-00002K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not my area, but I don't think exec_usermodehelper() should assume
> that current->files is always valid.
> 
> Al, is this correct?  If so, does daemonize() also need this test?
> If not, then how did this thread get (current->files == NULL)?

exit_files() will leave it NULL yes. You may want to borrow (inherit ;)) the
files from init_task

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbQKBW20>; Thu, 2 Nov 2000 17:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129787AbQKBW2Q>; Thu, 2 Nov 2000 17:28:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24656 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129780AbQKBW2J>; Thu, 2 Nov 2000 17:28:09 -0500
Subject: Re: select() bug
To: pmarquis@iname.com (Paul Marquis)
Date: Thu, 2 Nov 2000 22:27:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3A01E68C.EDA27165@iname.com> from "Paul Marquis" at Nov 02, 2000 05:11:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rSpZ-0001z2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that are log file handlers are dead.  If select() reports it can't
> write immediately, Apache terminates and restarts the child process,
> creating unnecessary load on the system.

Is there anything saying that select has to report ready the instant a byte
would fit. Certainly its better for performance to reduce the context switch
rate by encouraging blocking


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

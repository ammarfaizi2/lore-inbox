Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292941AbSCDWXE>; Mon, 4 Mar 2002 17:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292942AbSCDWWz>; Mon, 4 Mar 2002 17:22:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28683 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292941AbSCDWWr>; Mon, 4 Mar 2002 17:22:47 -0500
Subject: Re: FPU precision & signal handlers (bug?)
To: eries@there.com (Eric Ries)
Date: Mon, 4 Mar 2002 22:37:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203041858.g24IwW115990@thdev4.there.com> from "Eric Ries" at Mar 04, 2002 10:58:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16i15h-0000q9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> handlers. We use signals extensively in our program, and were quite
> surprised to find kernel FINIT traps being generated from them. After
> reading through the 2.4.2 source, I now believe that all signal
> handlers run with the default FPU control word in effect. Here's
> why...

Think about MMX and hopefully it makes sense then.

> strikes me as kind of a hack. Why should the signal handler, alone
> among all my functions (excepting main) be responsible for blowing
> away the control word?

Right - I would expect it to be restored at the end of the signal handler
for you - is that occuring or not ? I just want to make sure I understand
the precise details of the problem here.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSCCNdB>; Sun, 3 Mar 2002 08:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSCCNcw>; Sun, 3 Mar 2002 08:32:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33290 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285352AbSCCNcj>; Sun, 3 Mar 2002 08:32:39 -0500
Subject: Re: PATCH 2.4.18-rc2-ac1: hang on spinlock in "expand_stack"
To: buhr@telus.net (Kevin Buhr)
Date: Sun, 3 Mar 2002 13:47:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <87d6ymfkdf.fsf@saurus.asaurus.invalid> from "Kevin Buhr" at Mar 02, 2002 06:36:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hWL2-0004JH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've enclosed a patch against 2.4.18-rc2-ac1, but it appears the same
> bug still exists in 2.4.19-pre1-ac1.  The "ac"-branch version of
> "expand_stack" in "mm/mmap.c" has a code path that doesn't unlock the
> spinlock.  I noticed when a "gdb" bug tickled it and locked up my
> machine.

Thanks. Thats one I accidentally introduced when I was doing the strict
oom handling. I'll apply that

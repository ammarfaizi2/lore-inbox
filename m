Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUENQjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUENQjg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUENQjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:39:35 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:664 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261693AbUENQjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:39:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: elf@buici.com, rmk@arm.linux.org.uk
Subject: arm-lh7a40x IDE support in 2.6.6
Date: Fri, 14 May 2004 18:40:04 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405141840.04401.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was just porting my patches killing <asm/arch/ide.h> for
ARM to 2.6.6 when noticed that more work is needed now. :-(

arch/arm/mach-lh7a40x/ide-lpd7a40x.c
include/asm-arm/arch-lh7a40x/ide.h

Why it couldn't be done in drivers/ide/arm
(as discussed on linux-ide)?

Code from <asm/ide.h> is inlined into IDE core code in far too
many interesting places which greatly increasing complexity/insanity
to anybody trying to understand or change it.

The rule is simple:
	code outside drivers/ide SHOULDN'T need to know about <linux/ide.h>.

WTF everybody wants to be "smart" and abuses it?
[ and then people complain why IDE is so ugly ]

BTW does it even work as IDE polling code is not merged yet?

Bartlomiej


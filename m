Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270762AbTGVAT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 20:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270763AbTGVAT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 20:19:28 -0400
Received: from webmail.insa-lyon.fr ([134.214.79.204]:19076 "EHLO
	mail.insa-lyon.fr") by vger.kernel.org with ESMTP id S270762AbTGVAT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 20:19:26 -0400
Date: Tue, 22 Jul 2003 02:34:28 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org
Subject: Problem with kernel 2.4.21 and bttv
Message-ID: <20030722003428.GA17392@pc.aurel32>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.4i (2003-03-19)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have just switch from kernel 2.4.20 to kernel 2.4.21, and my TV card
(Miro PC/TV, BT878) stopped to work. I got a lot of the following messages 
when I try to access /dev/video0:

bttv: vmalloc_32(8519680) failed
bttv: vmalloc_32(8519680) failed
...

While grepping vmalloc in the kernel sources, I found the following line
in include/asm-i386/page.h:

#define __VMALLOC_RESERVE       (128 << 20)

I changed the value to 128 (MBytes I suppose) to 256, and my TV card 
started to work.

My computer is an AMD Ahtlon XP1800+, with a KT266A chipset and 1 GBytes
of RAM (and thus HighMem is enabled).

Has anybody the same problem, and is there other solutions to solve the
problem?

Cheers,
Aurelien

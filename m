Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275485AbRJKJ0J>; Thu, 11 Oct 2001 05:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275843AbRJKJZ7>; Thu, 11 Oct 2001 05:25:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51217 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275485AbRJKJZt>; Thu, 11 Oct 2001 05:25:49 -0400
Subject: Re: -ac10,-ac11 no boot on SMP PentiumII box
To: cshihpin@dso.org.sg (Richard Shih-Ping Chan)
Date: Thu, 11 Oct 2001 10:31:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), cshihpin@dso.org.sg (Richard Chan),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011011165636.B1174@cshihpin.dso.org.sg> from "Richard Shih-Ping Chan" at Oct 11, 2001 04:56:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rcC2-0002cu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've narrowed it down to the change between 2.4.10-ac8 and 
> -ac9. Maybe it has something to do with CONFIG_X86_PPRO_FENCE?

That is the obvious candidate. I changed spin_unlock for the ppro to cover
an errata. It seems to work for me with gcc 2.96 but its asm so its possible
I've done something some compiler version didnt like.

Switch the include/asm-i386/spinlock,h to the one in Linus tree and see
what happens

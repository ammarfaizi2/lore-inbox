Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbRE1NyJ>; Mon, 28 May 2001 09:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263064AbRE1Nx7>; Mon, 28 May 2001 09:53:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10514 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263062AbRE1Nxt>; Mon, 28 May 2001 09:53:49 -0400
Subject: Re: Kernel 2.4.5-ac2 OOPs when run pppd ?
To: haiquy@yahoo.com (=?iso-8859-1?q?Steve=20Kieu?=)
Date: Mon, 28 May 2001 14:51:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010528084855.10604.qmail@web10402.mail.yahoo.com> from "=?iso-8859-1?q?Steve=20Kieu?=" at May 28, 2001 06:48:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154NQp-000386-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeas it is stil the same as 2.4.5-ac1, but did not
> happen with 2.4.5; You can try running pppd in the
> console (tty1) without any argument.

Looks like an interaction with the newer console locking code. The BUG() is
caused when the ppp code tries to write to the console from inside an 
interrupt handler [now not allowed]

Alan




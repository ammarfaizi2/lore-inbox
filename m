Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRBXQ76>; Sat, 24 Feb 2001 11:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129461AbRBXQ7s>; Sat, 24 Feb 2001 11:59:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46866 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129446AbRBXQ7i>; Sat, 24 Feb 2001 11:59:38 -0500
Subject: Re: APM suspend system lockup under 2.4.2 and 2.4.2ac1
To: bradley_kernel@yahoo.com (bradley mclain)
Date: Sat, 24 Feb 2001 17:02:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010224052955.75158.qmail@web9204.mail.yahoo.com> from "bradley mclain" at Feb 23, 2001 09:29:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Wi5n-0000AV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the sound card is a yamaha YMF-744B.  i hadn't been
> compiling with sound support (i dont care about sound
> on my laptop), but when i got 2.4.2 i decided to try,
> and now i'm pretty sure that was the problem.

The Yamaha sound driver doesnt handle the case where the bios fails to restore
the chip status and expects a windows driver to do its dirty work. That
requires on resume that the device is completely reloaded.

A workaround is to make it a module, unload it before suspend and reload it
after resume but thats pretty umm uggly.

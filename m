Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262053AbTCRBAz>; Mon, 17 Mar 2003 20:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262055AbTCRBAz>; Mon, 17 Mar 2003 20:00:55 -0500
Received: from smtp4.wanadoo.nl ([194.134.35.175]:29236 "EHLO smtp4.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S262053AbTCRBAy>;
	Mon, 17 Mar 2003 20:00:54 -0500
From: "Marijn Kruisselbrink" <marijnk@gmx.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: RE: (2.5.65) Unresolved symbols in modules?
Date: Tue, 18 Mar 2003 02:11:54 +0100
Message-ID: <HJEOKOJLKINBOCDGFDOOOEOACCAA.marijnk@gmx.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.65; fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.65/kernel/drivers/char/lp.ko
> depmod:         parport_read
> depmod:         parport_set_timeout
> depmod:         parport_unregister_device
> ...
> [lots and lots of unresolved symbols in lots of modules]
>
> What am I doing wrong?  What web page or kernel documentation should I
> be reading?
I experienced exactly the same problems when I was running 2.5 kernels for
the first time. I think the problem is that the module-init-tools are
installed in /usr/local/sbin instead of /sbin. In /sbin are still the ol
dmodutils. When you simply run depmod, you will run the module-init-tools,
but in the linux-makefile /sbin/depmod is called. You could simply copy the
modutils to *.old (depmod -> depmod.old), and make symlinks/copys of the
module-init-tools in /sbin (or just make sure make isntall installs them
there).

Marijn Kruisselbrink


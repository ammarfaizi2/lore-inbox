Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268893AbTCCXZq>; Mon, 3 Mar 2003 18:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268894AbTCCXZb>; Mon, 3 Mar 2003 18:25:31 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:14993 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268893AbTCCXZS>;
	Mon, 3 Mar 2003 18:25:18 -0500
Date: Tue, 4 Mar 2003 00:35:40 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303032335.h23NZetq012628@harpo.it.uu.se>
To: rusty@rustcorp.com.au
Subject: 2.5 modprobe doesn't handle alias chains?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

In converting my 2.5 build to make the serial driver a module,
I discovered that alias chains in modprobe.conf apparently
don't work. This is with module-init-tools-0.9.9.

I had 'alias char-major-4 serial' and 'alias char-major-5 serial'
in modprobe.conf, since that's what's built into 2.4 modutils, and
then I added 'alias serial 8250'. This did not work: opening /dev/ttyS0
resulted in modprobe complaining 'FATAL: Module serial not found'.

Is this a bug or a design limitation?

I kludged it by using 'alias char-major-4 8250' instead.

/Mikael

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315788AbSENQAs>; Tue, 14 May 2002 12:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315790AbSENQAr>; Tue, 14 May 2002 12:00:47 -0400
Received: from daimi.au.dk ([130.225.16.1]:61236 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315788AbSENQAq>;
	Tue, 14 May 2002 12:00:46 -0400
Message-ID: <3CE134A7.1D49B497@daimi.au.dk>
Date: Tue, 14 May 2002 18:00:39 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-ac3
In-Reply-To: <200205141244.g4ECi6P29886@devserv.devel.redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like 3c509 is still buggy.

Any particular reason this patch didn't get applied?

diff -Nur linux.old/drivers/net/3c509.c linux.new/drivers/net/3c509.c
--- linux.old/drivers/net/3c509.c       Sat May 11 13:53:45 2002
+++ linux.new/drivers/net/3c509.c       Sat May 11 13:55:09 2002
@@ -567,7 +567,7 @@
 /* Read a word from the EEPROM using the regular EEPROM access register.
    Assume that we are in register window zero.
  */
-static ushort __init read_eeprom(int ioaddr, int index)
+static ushort read_eeprom(int ioaddr, int index)
 {
 	outw(EEPROM_READ + index, ioaddr + 10);
 	/* Pause for at least 162 us. for the read to take place. */

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk

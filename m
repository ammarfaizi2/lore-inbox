Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSLHXl7>; Sun, 8 Dec 2002 18:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSLHXl7>; Sun, 8 Dec 2002 18:41:59 -0500
Received: from mail.scssoft.com ([212.24.148.162]:11917 "EHLO mail.scssoft.com")
	by vger.kernel.org with ESMTP id <S261868AbSLHXl6>;
	Sun, 8 Dec 2002 18:41:58 -0500
Date: Mon, 9 Dec 2002 00:41:02 +0100
From: Petr Sebor <petr@scssoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, roubm9am@barbora.ms.mff.cuni.cz
Subject: Re: IDE feature request
Message-ID: <20021208234102.GA8293@scssoft.com>
References: <068d01c29d97$f8b92160$551b71c3@krlis> <1039312135.27904.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <1039312135.27904.11.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 08, 2002 at 01:09:34AM +0000, Alan Cox wrote:
> Fix ide.c to generate a b c d e f and you should be able to get 16.

Like this?

-Petr

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide.diff"

--- ide.c~	2002-12-09 00:26:38.000000000 +0100
+++ ide.c	2002-12-09 00:25:34.000000000 +0100
@@ -262,7 +262,7 @@
 	hwif->name[0]	= 'i';
 	hwif->name[1]	= 'd';
 	hwif->name[2]	= 'e';
-	hwif->name[3]	= '0' + index;
+	hwif->name[3]	= (index < 10)?('0' + index):('a' + index - 10);
 	hwif->bus_state = BUSSTATE_ON;
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];

--azLHFNyN32YCQGCU--

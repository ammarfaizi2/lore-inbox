Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269435AbRGaT2m>; Tue, 31 Jul 2001 15:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269434AbRGaT2e>; Tue, 31 Jul 2001 15:28:34 -0400
Received: from OL105-132.fibertel.com.ar ([24.232.132.105]:36370 "EHLO
	burns.luca.2y.net") by vger.kernel.org with ESMTP
	id <S269436AbRGaT2R>; Tue, 31 Jul 2001 15:28:17 -0400
Message-Id: <200107312035.QAA26833@burns.luca.2y.net>
Date: Tue, 31 Jul 2001 16:28:11 -0300 (ART)
From: Leandro Lucarella <luca@lucarella.com.ar>
Subject: [patch] Leadtek Winview 601TV bad audios flags fix
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1804289383-996607692=:29241"
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.4 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

--8323328-1804289383-996607692=:29241
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

Hi, I was using my Leadtek WinView 601TV card for a long time with some
problems with audio... A few days ago I decided to take a look to the
kernel's source (I never did it before, I was so afraid ;) and I founded
and fixed the problem. It was a bad flag of the audios structure.
Here's the patch. It's for drivers/media/video/bttv-cards.c

--8323328-1804289383-996607692=:29241
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="bttv-cards.c-patch"
Content-Disposition: INLINE; FILENAME="bttv-cards.c-patch"

--- bttv-cards.c-old	Tue Jul 31 16:19:00 2001
+++ bttv-cards.c-fixed	Tue Jul 31 16:18:38 2001
@@ -1394,7 +1394,8 @@
 	int bits_out, loops, vol, data;
 
 	if (!set) {
-		v->mode |= VIDEO_AUDIO_VOLUME;
+		/* Fixed by Leandro Lucarella <luca@linuxmendoza.org.ar (07/31/01) */
+		v->flags |= VIDEO_AUDIO_VOLUME;
 		return;
 	}
 	

--8323328-1804289383-996607692=:29241
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE


--
LUCA - Leandro Lucarella
------------------------
luca@lucarella.com.ar
http://www.luca.2y.net
LICQ UIN: 2847576
------------------------
Usando Debian GNU/Linux

--8323328-1804289383-996607692=:29241--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284545AbRLIWX1>; Sun, 9 Dec 2001 17:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284548AbRLIWXS>; Sun, 9 Dec 2001 17:23:18 -0500
Received: from [144.137.80.33] ([144.137.80.33]:23534 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id <S284545AbRLIWXI>;
	Sun, 9 Dec 2001 17:23:08 -0500
Message-ID: <3C13E25C.5E323277@eyal.emu.id.au>
Date: Mon, 10 Dec 2001 09:14:52 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre7 - fdomain_stub.c error
In-Reply-To: <Pine.LNX.4.21.0112091722050.24350-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------8026A2A24BDB50E5447F0468"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8026A2A24BDB50E5447F0468
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes pre7.

linux/drivers/scsi/pcmcia/fdomain_stub.c does not compile. I think
this is the fix.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------8026A2A24BDB50E5447F0468
Content-Type: text/plain; charset=us-ascii;
 name="2.4.17-pre7-fdomain.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.17-pre7-fdomain.patch"

--- linux/drivers/scsi/fdomain.h.orig	Mon Dec 10 09:09:28 2001
+++ linux/drivers/scsi/fdomain.h	Mon Dec 10 09:10:14 2001
@@ -34,6 +34,7 @@
 int        fdomain_16x0_biosparam( Disk *, kdev_t, int * );
 int        fdomain_16x0_proc_info( char *buffer, char **start, off_t offset,
 				   int length, int hostno, int inout );
+int        fdomain_16x0_release( struct Scsi_Host *shpnt );
 
 #define FDOMAIN_16X0 { proc_info:      fdomain_16x0_proc_info,           \
 		       detect:         fdomain_16x0_detect,              \

--------------8026A2A24BDB50E5447F0468--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265394AbRGBSgL>; Mon, 2 Jul 2001 14:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265395AbRGBSgB>; Mon, 2 Jul 2001 14:36:01 -0400
Received: from denise.shiny.it ([194.20.232.1]:47776 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S265394AbRGBSf4>;
	Mon, 2 Jul 2001 14:35:56 -0400
Message-ID: <3B3DEA3D.251CB340@denise.shiny.it>
Date: Sat, 30 Jun 2001 17:03:25 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCSI I/O error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From my logs:

Jun 29 14:19:56 Jay kernel: SCSI disk error : host 1 channel 0 id 5 lun 0
return code = 8000002
Jun 29 14:19:56 Jay kernel: Current sd08:11: sense key Recovered Error
Jun 29 14:19:56 Jay kernel: Additional sense indicates Recovered data with
error correction applied
Jun 29 14:19:56 Jay kernel:  I/O error: dev 08:11, sector 480940
Jun 29 14:19:56 Jay kernel: Incorrect number of segments after building list

I programmed the disk to report recovered errors too, and the
log shows one of these. The user-level tool exited with an
I/O error.
The last line comes from drivers/scsi/scsi_merge.c:__init_io()
and I thing there is a bug in the SCSI error handling code.
I have an Adaptec card.

[Linux version 2.4.6-pre3]

Bye.


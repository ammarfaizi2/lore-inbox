Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270795AbRIJMKr>; Mon, 10 Sep 2001 08:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270774AbRIJMKg>; Mon, 10 Sep 2001 08:10:36 -0400
Received: from mailgwa0.bmwgroup.com ([192.109.190.231]:49973 "EHLO
	mailgwa0.bmwgroup.com") by vger.kernel.org with ESMTP
	id <S270795AbRIJMK3>; Mon, 10 Sep 2001 08:10:29 -0400
Message-Id: <3B9CADC3.EE8BFF63@partner.bmw.de>
Date: Mon, 10 Sep 2001 14:10:43 +0200
From: Roderich Schupp <Roderich.Schupp@partner.bmw.de>
Organization: argumentum GmbH
X-Mailer: Mozilla 4.72 [de]C-CCK-MCD   (WinNT; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with SCSI emulation and suspend
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
recently I noticed the following strange behaviour with
my laptop (Toshiba Satellite 4300 series):

When I have a CDROM mounted and then suspend/resume, I get
errors accessing the files on the CDROM (at least those
whose contents are not in the page cache). Applications
trying to read get EIO and syslog shows:

Sep 09 12:21:04 click kernel:  I/O error: dev 0b:00, sector 292748

and sometimes also

Sep 09 12:26:08 click kernel: SCSI cdrom error : host 0 channel 0 id 0
lun 0 return code = 28000000
Sep 09 12:26:08 click kernel: ILI Current sd0b:00: sense key Illegal
Request
Sep 09 12:26:08 click kernel: Additional sense indicates Illegal mode
for this track
Sep 09 12:26:08 click kernel:  I/O error: dev 0b:00, sector 315304

Note that I use SCSI over IDE emulation to access the CDROM drive.
The problem doesn't show when I switch to "pure" IDE access.
Also, even when using IDE SCSI, it's just that accesses via the
filesystem fail, reading the device with e.g. dd shows
no problems.

Kernel is vanilla 2.4.9-pre4.

Cheers, Roderich


 
------------------------------------------------------------------
      sw-engineering & production environment at BMW group
------------------------------------------------------------------
roderich schupp                     roderich.schupp@partner.bmw.de       
dipl.math.                          tel  : +49 (0)89 382   -34944
argumentum gmbh                     fax  : +49 (0)89 38270 -34944

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278163AbRKSO3C>; Mon, 19 Nov 2001 09:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278381AbRKSO2y>; Mon, 19 Nov 2001 09:28:54 -0500
Received: from [195.66.192.167] ([195.66.192.167]:21252 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S278163AbRKSO2i>; Mon, 19 Nov 2001 09:28:38 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Mount opts: make umask and friends valid for any fs
Date: Mon, 19 Nov 2001 16:28:23 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01111916282302.00817@nemo>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently some fs support umask=NNN mount opt to indicate which mode bits to 
clear for all files/dirs (mostly those which don't have support for mode: 
vfat etc). Some also have fmask/dmask (smbfs).

Would it be useful to make those a generic mount opts applicable to any fs:
u[f]mask=NNN: bits to clear for files and dirs
udmask=NNN: bits to clear for dirs (overrides umask)
[f]mask=NNN: bits to set for files and dirs
dmask=NNN: bits to set for dirs (overrides fmask)

Note: this mess with file/dir separation is due to historical
'x bit for dirs' (mis)feature
--
vda

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTJRTKI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTJRTKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:10:08 -0400
Received: from mail.gmx.de ([213.165.64.20]:63403 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261768AbTJRTKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:10:05 -0400
Date: Sat, 18 Oct 2003 21:10:04 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: initrd and 2.6.0-test8
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <22900.1066504204@www30.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

me had  the same problems,
with devfs enabled

could it be this (from Documentation/initrd)

Note that changing the root directory does not involve unmounting it.
    the "normal" root file system is mounted. initrd data can be read
  root=/dev/ram0   (without devfs)
  root=/dev/rd/0   (with devfs)
    initrd is mounted as root, and the normal boot procedure is followed,
    with the RAM disk still mounted as root.

the patch doesn't mention anything about /dev/rd/0 , but does for /dev/ram0

svetljo

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++


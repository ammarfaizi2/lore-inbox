Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315020AbSDWCkM>; Mon, 22 Apr 2002 22:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315024AbSDWCkL>; Mon, 22 Apr 2002 22:40:11 -0400
Received: from zok.SGI.COM ([204.94.215.101]:35275 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315020AbSDWCkL>;
	Mon, 22 Apr 2002 22:40:11 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.9 ide compile error
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 12:40:00 +1000
Message-ID: <10355.1019529600@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide.c: In function `ide_teardown_commandlist':
ide.c:2845: structure has no member named `pci_dev'
make[3]: *** [ide.o] Error 1
make[3]: Leaving directory `/build/kaos/2.5.9-kdb/drivers/ide'

pci_dev is unconditionally used but the field is only defined when
CONFIG_BLK_DEV_IDEPCI=y.


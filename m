Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262746AbSJCFrj>; Thu, 3 Oct 2002 01:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbSJCFri>; Thu, 3 Oct 2002 01:47:38 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:56961 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S262746AbSJCFri>; Thu, 3 Oct 2002 01:47:38 -0400
Date: Thu, 3 Oct 2002 07:53:08 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.40: CONFIG_CRC32=Y is broken
Message-ID: <Pine.LNX.4.44.0210030741150.11397-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seems that CONFIG_CRC32=Y is broken.  The symbols crc32_le and crc32_be
do not appear in the System.map file, and insmod complains about crc32_be
being missing when trying to load the module via-rhine.o.

I suspect that it happens because crc32.o is put in a lib file (.a), and
since the functions are not used at link time, the file (crc32.o) is
dropped.

/Tobias


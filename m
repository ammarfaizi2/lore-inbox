Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317129AbSFFSt2>; Thu, 6 Jun 2002 14:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSFFSsD>; Thu, 6 Jun 2002 14:48:03 -0400
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:24555 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S317096AbSFFSqa>; Thu, 6 Jun 2002 14:46:30 -0400
Message-ID: <000701c20d8a$7234b520$66aca8c0@kpfhome>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Subject: kbuild-2.5 2.4.19-pre10-ac2 "automatic" make installable?
Date: Thu, 6 Jun 2002 11:46:19 -0700
Organization: Laboratory Systems Group, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I unpacked a new kernel tree, patched up to 2.4.19-pre10-ac2. I then applied
the kbuild-2.5 patch for this version (from stingr), and did a make
oldconfig/make installable/make install. Everything went just fine.

I rebooted, and decided to make some changes to the config. I went back into
the source tree, and renamed Makefile to Makefile-2.4 and Makefile-2.5 to
Makefile (so I don't have to keep specifying -f Makefile-2.5). I then did
"make menuconfig", and turned on loadable module support and the kernel
module loader. After the configuration got saved, kbuild automatically
started a "make installable" pass! Although I was planning on doing this
anyway, I don't think was expected behavior.


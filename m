Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTKZX1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTKZX1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:27:39 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:22776 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S264382AbTKZX1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:27:38 -0500
Message-ID: <02d801c3b474$e09e42a0$02c8a8c0@steinman>
Reply-To: "Adam Kropelin" <akropel1@rochester.rr.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <linux-kernel@vger.kernel.org>
Cc: <sam@mars.ravnborg.org>
Subject: Parallel build not working since -test6?
Date: Wed, 26 Nov 2003 18:27:37 -0500
Organization: Kroptech
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lately I've noticed my kernel compilations taking longer than usual. Tonight
I finally realized the cause... Parallel building (i.e. make -jN) is no
longer working for me. I traced it back and the last kernel it worked in
was -test5. It ceased working in -test6.

Not to point fingers, but I do notice that the kbuild separate output
directory patch went into -test6...

Build environment details:
arch: i386
make: GNU Make version 3.79.1
gcc: gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
output directory: default (i.e. source dir)

I can narrow it down to a -bk if that's useful or if someone has a patch to
back out the separate output dir kbuild changes I can give that a whirl...

--Adam


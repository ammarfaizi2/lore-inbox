Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSDYSUc>; Thu, 25 Apr 2002 14:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313304AbSDYSUc>; Thu, 25 Apr 2002 14:20:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34433 "EHLO
	e33.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S313300AbSDYSUb>; Thu, 25 Apr 2002 14:20:31 -0400
Subject: [RFC][PATCH] Early console/printk patch
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.9a  January 7, 2002
Message-ID: <OFC06C7165.A501449A-ON87256BA6.006469C0-88256BA6.006471AC@boulder.ibm.com>
From: "Keith Mannthey" <kmannth@us.ibm.com>
Date: Thu, 25 Apr 2002 12:19:11 -0600
X-MIMETrack: Serialize by Router on D03NM008/03/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/25/2002 12:19:12 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

        The following is a patch which provides early printk support.
It provides a way to add a console in seup_arch and then
automatically have it removed just before the real console is added.
It provides a way to debug kernels that don't boot past console_init
or that overflow the temp buffer.  It also provides 3 simple consoles
for i386 (mainly vga and serial) that support write.  It allows you to
just make printk calls and see them on your console before
console_init.

         A big piece of the patch was written by William Irwin and had
been previously submitted by him (NOV 2001).  The patch is against
a base 2.4.17 but should be easy to apply against other versions of
the kernel.

Please let us know what you think about getting this into the kernel.


http://prdownloads.sourceforge.net/lse/patch-2.4.17-early_console

Keith Mannthey
kmannth@us.ibm.com




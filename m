Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268857AbUHZNEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268857AbUHZNEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268870AbUHZND3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:03:29 -0400
Received: from webapps.arcom.com ([194.200.159.168]:63759 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S268857AbUHZMyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:54:07 -0400
Subject: Build error with recent BK and O=
From: Ian Campbell <icampbell@arcom.com>
To: sam@ravnborg.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1093524839.12997.11.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 13:53:59 +0100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Aug 2004 12:57:03.0343 (UTC) FILETIME=[2EF00FF0:01C48B6C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

When building an x86 kernel from a BK tree from a few hours ago with
O=../build-2.6-gx1 I got the following error:

  ccache gcc -Wp,-MD,arch/i386/boot/tools/.build.d -Iarch/i386/boot -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I/home/icampbell/devel/kernel/i386/linux-2.6-bk/include -Iinclude -I/home/icampbell/devel/kernel/i386/linux-2.6-bk/include2 -Iinclude2  -I/home/icampbell/devel/kernel/i386/linux-2.6-bk/include  -o arch/i386/boot/tools/build /home/icampbell/devel/kernel/i386/linux-2.6-bk/arch/i386/boot/tools/build.c
cc1: No such file or directory: opening dependency file arch/i386/boot/tools/.build.d

Doing "mkdir ../build-2.6-gx1/arch/i386/boot/tools" allowed the build to
continue. It smells like a problem with the hostprogs-y = tools/build in
arch/i386/boot/Makefile not coping with the subdirectory, but I don't
know much about kbuild myself.

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


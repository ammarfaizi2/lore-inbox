Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269433AbTCDQ54>; Tue, 4 Mar 2003 11:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269434AbTCDQ54>; Tue, 4 Mar 2003 11:57:56 -0500
Received: from amdext2.amd.com ([163.181.251.1]:14016 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S269433AbTCDQ5z> convert rfc822-to-8bit;
	Tue, 4 Mar 2003 11:57:55 -0500
From: ravikumar.chakaravarthy@amd.com
X-Server-Uuid: BB5E7757-34FD-4146-B9CC-0950D472AE87
Message-ID: <99F2150714F93F448942F9A9F112634CA54B07@txexmtae.amd.com>
To: linux-kernel@vger.kernel.org
Subject: Loading and executing kernel from a non-standard address using
 SY SLINUX
Date: Tue, 4 Mar 2003 11:08:10 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 127A02F52096873-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to load and boot the kernel from a non-standard address
(0x200000). I am using the SYSLINUX boot loader, which loads the
kernel at that address. I have also made changes to the kernel to
setup code and startup_32() function to effect the same. When I boot
the system It says

Loading.......... Ready
Uncompressing Linux... OK Booting the kernel

and then hangs.

I guess the reason being the System.map entries are still using the
PAGE_OFFSET = 0xc0000000, as opposed to 0xc0100000.
I have the following questions??

1. How do i change the System.map to get the right PAGE_OFFSET.
2. Will it work if I load and boot the kernel from a different address
like (0xdf000000)??

3. Am I in the right track or missing something.

Thanks
  -Ravi



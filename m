Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSECIJX>; Fri, 3 May 2002 04:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315594AbSECIJW>; Fri, 3 May 2002 04:09:22 -0400
Received: from 24.213.60.123.up.mi.chartermi.net ([24.213.60.123]:29825 "EHLO
	front1.chartermi.net") by vger.kernel.org with ESMTP
	id <S315593AbSECIJU>; Fri, 3 May 2002 04:09:20 -0400
Message-ID: <3CD244A7.2F445E07@chartermi.net>
Date: Fri, 03 May 2002 04:04:55 -0400
From: Keith Velleux <velleux@chartermi.net>
X-Mailer: Mozilla 4.74 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: general@yellowdoglinux.com, linux-kernel@vger.kernel.org
Subject: Who should get kernel bug reports (Both at YDL and Kernel Folks)?
X-Priority: 1 (Highest)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I recently upgraded to YDL 2.2 (from LinuxPPC2K-Q4) and Kernel 2.4.18.
The computer is a PowerMac 8500 (circa 1995).

I found a bug in the controlfb.c file for the kernel.
(/usr/src/linux-2.4.18/drivers/video/controlfb.c)

The kernel commandline video options ("video=controlfb:vmode:17" for
example) do not work.

The routine "control_setup" reads the commandline correctly and sets
"default_vmode".

The problem is in the routine "init_control".
It does not use "default_vmode" to set "vmode".
(The exception is when there is no commandline option, then
"default_vmode == VMODE_NVRAM")

Reviewing the 2.2.20 kernel shows that the NVRAM "if" checks in
"init_control" need "else" statements.
["else vmode=default_vmode;"]

The same applies to "default_cmode".

Thank you.

Sincerely,
Keith Velleux

P.S.  It is 4:00 AM, and I can no longer think.


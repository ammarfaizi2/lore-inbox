Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTEBIhU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 04:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTEBIhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 04:37:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:53469 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261953AbTEBIhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 04:37:19 -0400
Date: Fri, 2 May 2003 11:06:32 +0200 (CEST)
From: Bodo Rzany <bodo@rzany.de>
X-X-Sender: bo@joel.ro.ibrro.de
To: linux-kernel@vger.kernel.org
Subject: is there small mistake in lib/vsprintf.c of kernel 2.4.20 ?
Message-ID: <Pine.LNX.4.44.0305021018070.493-100000@joel.ro.ibrro.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM:
	Hex/Octal decoding with sscanf from kernel library does not work
	within kernel 2.4.20

DESCRIPTION:
	Line 570 in lib/vsprintf.c

			14677 11. Okt 2001  vsprintf.c

	holds '	base = 10; '

	which prevents the real conversion routines ('simple_strtoul' a.s.o.)
	from decoding numbers from bases other than 10.

(possible?) SOLUTION:

	Changing line 570 from ' base = 10; ' to ' base = 0;' works for me.
	I have found no side effects up to now, but I am not sure that there
	might be some.

I am by no means a kernel professional or an experienced c-programmer, so I
hope that some of the linux gurus can have a look at this little problem.

I am sorry not to have any sample code for you, that shows the error.
I have discovered the problem on writing a small kernel module for driving
a home brewed TUSB3410-development-board, and this modul needs the special
hardware to be functional.

If there should be some interest on this kernel module for USB hard- and
software development (the TUSB3410 from Texas Instruments is a programmable
USB to serial converter), I would be proud to release this small work to the
public (including the hardware and, if of further interest, the TUSB-code).

Thanks for all the good linux code I can work with, and

Best regards

Bodo Rzany
<bodo@rzany.de>


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130233AbRBAKbL>; Thu, 1 Feb 2001 05:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130353AbRBAKbC>; Thu, 1 Feb 2001 05:31:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:274 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130233AbRBAKas>;
	Thu, 1 Feb 2001 05:30:48 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102011024.f11AOQF12603@flint.arm.linux.org.uk>
Subject: Re: Linuxrc runs with PID 7
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Thu, 1 Feb 2001 10:24:26 +0000 (GMT)
Cc: moloch16@yahoo.com (Paul Powell), linux-kernel@vger.kernel.org
In-Reply-To: <200102010901.KAA05572@cave.bitwizard.nl> from "Rogier Wolff" at Feb 01, 2001 10:01:03 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, a /linuxrc script can't be PID 1.  Check the bottom of
do_basic_setup in init/main.c:

                pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);

Since do_basic_setup is already PID 1, /linuxrc won't be.

If you need /linuxrc to be PID 1, don't call it /linuxrc, but /sbin/init,
/etc/init or /bin/init.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

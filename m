Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291194AbSAaRlp>; Thu, 31 Jan 2002 12:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291195AbSAaRlf>; Thu, 31 Jan 2002 12:41:35 -0500
Received: from smtp-sec1.zid.nextra.de ([212.255.127.204]:48394 "EHLO
	smtp-sec1.zid.nextra.de") by vger.kernel.org with ESMTP
	id <S291194AbSAaRlZ>; Thu, 31 Jan 2002 12:41:25 -0500
Date: Thu, 31 Jan 2002 18:36:50 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: ARM Linux kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: serial input overruns
In-Reply-To: <D99C1FB421989A40818B6370E31870940283A8C2@tayexc19.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.33.0201311831110.3425-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On an ARM board we're trying to transmit data with 921600 bauds and we're
getting input overruns, and the handshaking line is not set... It's a
SA-1100 external UART. I checked - this message comes from
drivers/char/n_tty.c:
n_tty_receive_overrun(tty);
called from
n_tty_receive_buf
which is a member in
struct tty_ldisc tty_ldisc_N_TTY...

Here my quick look stopped - I know nothing about how tty work... Where's
the problem? It's 2.4.13-ac5-rmk2 with local modifications... (Trizeps
board).

Thanks in advance
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany



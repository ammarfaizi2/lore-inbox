Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266969AbUAXQap (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 11:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266968AbUAXQap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 11:30:45 -0500
Received: from smtp1.libero.it ([193.70.192.51]:40904 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S266961AbUAXQak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 11:30:40 -0500
Date: Sat, 24 Jan 2004 17:31:00 +0100
From: "Angelo Dell'Aera" <buffer@antifork.org>
To: Linux-Net <linux-net@vger.kernel.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ppp_async problem?
Message-Id: <20040124173100.7ae8f7f8.buffer@antifork.org>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
X-PGP-Program: GNU Privacy Guard (http://www.gnupg.org)
X-PGP-PublicKey: http://buffer.antifork.org/privacy/buffer-gpg.asc
X-PGP-Fingerprint: 48CC B0D8 C394 CD30 355F E36D A4E3 48CF 19C1 5CA2
X-Operating-System: GNU-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


While booting I saw this. The call trace is repeated few times.
I reported it just one time. The kernel is 2.6.1. 

PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c01222fd>] local_bh_enable+0x8d/0x90
 [<e2b36c12>] ppp_async_push+0xa2/0x1a0 [ppp_async]
 [<e2b364d1>] ppp_asynctty_wakeup+0x31/0x70 [ppp_async]
 [<c0203d65>] uart_flush_buffer+0x75/0x80
 [<c01df277>] do_tty_hangup+0x487/0x4f0
 [<c012df7f>] worker_thread+0x1ff/0x2e0
 [<c01dedf0>] do_tty_hangup+0x0/0x4f0
 [<c011ac30>] default_wake_function+0x0/0x20
 [<c01091b2>] ret_from_fork+0x6/0x14
 [<c011ac30>] default_wake_function+0x0/0x20
 [<c012dd80>] worker_thread+0x0/0x2e0
 [<c01070d9>] kernel_thread_helper+0x5/0xc

Regards.

- --

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org

PGP information in e-mail header


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAEp3EpONIzxnBXKIRAn79AJ9T8PukmxUToQ7bSj/TKYOioZqbwQCeNvQi
AusiTLjI1CrZVrV1TE58rI4=
=XuYc
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946224AbWKAAPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946224AbWKAAPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946228AbWKAAPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:15:32 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:57572 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1946224AbWKAAPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:15:32 -0500
Message-ID: <4547E720.4080505@gmail.com>
Date: Wed, 01 Nov 2006 01:15:28 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: R.E.Wolff@BitWizard.nl
Subject: preferred way of fw loading
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is preferred to have firmware in kernel binary (and go through array of chars)
or userspace (and load it through standard kernel api)?

For char sx driver in this case (I hope there is no later fw):
ftp://ftp.bitwizard.nl/specialix/sx_firmware_306c.tgz

Now it's 2 .c files used by loader through ioctl. After compilation it has:
   text    data     bss     dec     hex filename
      4    8416       2    8422    20e6 si2_z280.o
      4   19484       2   19490    4c22 si3_t225.o

So convert it to binary (and load it through userspace) or simply #include it in
the sources? I hope the former is preferred?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

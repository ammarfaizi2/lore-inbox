Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUAAWW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbUAAWW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:22:26 -0500
Received: from p50829056.dip.t-dialin.net ([80.130.144.86]:15115 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S265201AbUAAWVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:21:33 -0500
Date: Thu, 1 Jan 2004 22:21:28 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: mchouque@online.fr, jbglaw@lug-owl.de
Subject: [alpha] link failure in 2.6.1-rc1
Message-ID: <20040101222128.A24172@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	mchouque@online.fr, jbglaw@lug-owl.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happy new year!
I finally decided to jump onto the 2.6 wagon, but unfortunately compilation
failed:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
init/built-in.o(.text+0x708): In function `huft_build':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0xa08): In function `huft_free':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0xf10): In function `inflate_codes':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0xf7c): In function `inflate_codes':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0xf84): In function `inflate_codes':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0xf8c): In function `inflate_codes':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0xf94): In function `inflate_codes':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0xfe8): In function `inflate_codes':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0xff0): In function `inflate_codes':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0x1000): In function `inflate_codes':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0x1220): In function `inflate_stored':
: additional relocation overflows omitted from the output
local symbol 0: discarded in section `.exit.text' from drivers/built-in.o
local symbol 1: discarded in section `.exit.text' from drivers/built-in.o
make: *** [.tmp_vmlinux1] Error 1
ds20:/usr/src/linux-2.6.1-rc1# 


This is an dual-alpha ev6 box (compaq DS20),
gcc version 3.3,
GNU ld version 2.14.90.0.7 20031029

I found thread about a similar problem  in the archive 
<http://lkml.org/lkml/2003/9/3/149> but the topic didn't seem to be 
resolved there.

any thoughts?

Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |

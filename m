Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWGBHmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWGBHmP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 03:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWGBHmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 03:42:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47841 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751145AbWGBHmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 03:42:14 -0400
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59:
	undefined reference to `__stack_chk_fail'
From: Arjan van de Ven <arjan@infradead.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
	 <1151788673.3195.58.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>
	 <1151789342.3195.60.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 09:42:10 +0200
Message-Id: <1151826131.3111.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> https://wiki.ubuntu.com/GccSsp
> 
> It appears that Ubuntu's Edgy Eft (the development tree) now contains
> "Stack Smashing Protection" enabled by default.  I found a web page
> that states that -fno-stack-protector can be used to disable this
> functionality.  Interestingly, another web page stated that SSP has
> been enabled in Redhat compilers for a long time and is now also
> enabled in Debian SID.  Perhaps -fno-stack-protector should be added
> to the kernel build be default?


gcc 4.1 and later have this feature yes.
HOWEVER the gcc people were not stupid, they did not force this on
people, they require you to put -fstack-protector on the commandline.
Debian and RH/Fedora do this.
If Ubuntu patched gcc rather than just putting it in the build
environment... then you should switch to a less braindead distribution
really ;)
or at least ask them to fix this.

Greetings,
   Arjan van de Ven


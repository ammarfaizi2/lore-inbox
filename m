Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269316AbUI3QFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269316AbUI3QFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269314AbUI3QFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:05:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:58347 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269316AbUI3QFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:05:34 -0400
Date: Thu, 30 Sep 2004 08:58:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tom Dickson <tdickson@inostor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why doesn't memchr appear in ksyms?
Message-Id: <20040930085855.1b79c63a.rddunlap@osdl.org>
In-Reply-To: <415C2C25.7030807@inostor.com>
References: <415C2C25.7030807@inostor.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2004 08:54:13 -0700 Tom Dickson wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| According to
| http://kernelnewbies.org/documents/kdoc/kernel-api/r1708.html I should
| be able to use memchr in a module, however, when I try to load the
| module insmod complains that memchr is not available; a grep memchr
| /proc/ksyms shows that it doesn't exist.
| 
| Is there some special kernel option I have to set to enable it? memcpy
| and other mem* externs are there.
| 
| Thank you (for answering a simple question)
| 
| Kernel 2.4.26 on a Pentium 3 system

memchr() is compiled/built inline, not as an exported function.

If it's not working for you, maybe you aren't building with "-O2"
(gcc optimization level 2), which is needed for kernel builds.


--
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUB0A57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbUB0A4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:56:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:37543 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261585AbUB0Ayv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:54:51 -0500
Date: Thu, 26 Feb 2004 16:54:46 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Carlos Silva" <r3pek@r3pek.homelinux.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: kexec "problem" [and patch updates]
Message-Id: <20040226165446.16a5bb3b.rddunlap@osdl.org>
In-Reply-To: <28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
References: <20040224160341.GA11739@in.ibm.com>
	<28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 11:02:21 -0000 (WET) Carlos Silva wrote:

| hi guys,
| 
| i have just compiled a kernel with the kexec patch. compiled kexec-tools
| and when i try to load a kernel, it gives me this:
| # ./do-kexec.sh /boot/bzImage-2.6.2-g
| kexec_load failed: Invalid argument
| entry       = 0x91764
| nr_segments = 2
| segment[0].buf   = 0x80b3480
| segment[0].bufsz = 1880
| segment[0].mem   = 0x90000
| segment[0].memsz = 1880
| segment[1].buf   = 0x40001008
| segment[1].bufsz = 19795a
| segment[1].mem   = 0x100000
| segment[1].memsz = 19795a
| 
| anyone tried to run kexec and actually did it? i'm trying with kernel 2.6.3
| -

I updated the kexec patch for 2.6.2 and 2.6.3.
It works fine on 2.6.2.  It works for me on 2.6.3 if not SMP.
If the kernel is built for SMP, when running kexec, I get a
BUG in arch/i386/kernel/smp.c at line 359.
I'm testing various workarounds for that BUG now.

--
~Randy

kexec updates are at:
http://developer.osdl.org/rddunlap/kexec/2.6.2/
and
http://developer.osdl.org/rddunlap/kexec/2.6.3/

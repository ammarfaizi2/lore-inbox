Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTHYQzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTHYQzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:55:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:22505 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261844AbTHYQzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:55:44 -0400
Date: Mon, 25 Aug 2003 09:50:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: selinux build failure
Message-Id: <20030825095055.7d73b93b.rddunlap@osdl.org>
In-Reply-To: <200308250006.h7P06Ax0022635@post.webmailer.de>
References: <o4Fj.1rw.9@gated-at.bofh.it>
	<o4YO.1Fl.21@gated-at.bofh.it>
	<200308250006.h7P06Ax0022635@post.webmailer.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Aug 2003 02:21:08 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

| James Morris wrote:
| 
| > On Sun, 24 Aug 2003, Christoph Hellwig wrote:
| > 
| >> Argg, this is b0rked.  {asm,linux}/compat.h are for the 32bit compatiblity
| >> code.  64bit arches don't have fcntl64 - see the #if BITS_PER_LONG == 32
| >> around sys_fcntl64 in fcntl.c..
| > 
| > Indeed.  How about this?

Yes, the second patch fixes for me also.  [2.6.0-test4 now]
I also see the warnings below.

| security/selinux/hooks.c: In function `selinux_bprm_set_security':
| security/selinux/hooks.c:1384: warning: cast to pointer from integer of different size
| security/selinux/hooks.c:1430: warning: cast to pointer from integer of different size
| security/selinux/hooks.c: In function `selinux_bprm_compute_creds':
| security/selinux/hooks.c:1520: warning: cast from pointer to integer of different size
| security/selinux/hooks.c: In function `selinux_getprocattr':
| security/selinux/hooks.c:3147: warning: passing arg 3 of `security_sid_to_context' from incompatible pointer type

Thanks.
--
~Randy   [mantra:  Always include kernel version.]
"Everything is relative."

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161244AbWJYBvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbWJYBvU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 21:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbWJYBvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 21:51:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161244AbWJYBvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 21:51:19 -0400
Date: Wed, 25 Oct 2006 03:51:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Muli Ben-Yehuda <muli@il.ibm.com>, Gleb Natapov <glebn@voltaire.com>,
       Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Patrick McHardy <kaber@trash.net>, herbert@gondor.apana.org.au,
       linux-crypto@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>, linux-390@vm.marist.edu,
       David Miller <davem@davemloft.net>,
       Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, Jesper Juhl <jesper.juhl@gmail.com>,
       David Howells <dhowells@redhat.com>, Andrey Panin <pazke@donpac.ru>,
       linux-visws-devel@lists.sourceforge.net,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Trent Piepho <xyzzy@speakeasy.org>, v4l-dvb-maintainer@linuxtv.org
Subject: 2.6.19-rc3: known regressions with patches
Message-ID: <20061025015115.GH27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.19-rc3 compared 
to 2.6.18 with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : "ACPI: PCI interrupt for device ... disabled"
References : http://lkml.org/lkml/2006/10/21/227
             http://lkml.org/lkml/2006/10/23/89
Submitter  : Muli Ben-Yehuda <muli@il.ibm.com>
             Gleb Natapov <glebn@voltaire.com>
Caused-By  : Yinghai Lu <yinghai.lu@amd.com>
             commit 45edfd1db02f818b3dc7e4743ee8585af6b78f78
Handled-By : Eric W. Biederman <ebiederm@xmission.com>
Patch      : http://marc.theaimsgroup.com/?l=linux-kernel&m=116157813623508&w=2
             http://marc.theaimsgroup.com/?l=linux-kernel&m=116157837104613&w=2
Status     : patches available


Subject    : missing select's of CRYPTO_ECB
References : http://lkml.org/lkml/2006/10/22/203
Submitter  : Alistair John Strachan <s0348365@sms.ed.ac.uk>
Handled-By : Patrick McHardy <kaber@trash.net>
Patch      : http://lkml.org/lkml/2006/10/23/207
Status     : patch available


Subject    : s390: Point sys_getcpu_wrapper at the proper syscall
References : http://lkml.org/lkml/2006/10/19/72
Submitter  : Paul Mundt <lethal@linux-sh.org>
Caused-By  : Heiko Carstens <heiko.carstens@de.ibm.com>
             commit 8abfe01dae8c0ed7ca6bfb153a7fcab47df72a52
Handled-By : Paul Mundt <lethal@linux-sh.org>
Patch      : http://lkml.org/lkml/2006/10/19/72
Status     : patch available


Subject    : pci_fixup_video change blows up on sparc64
References : http://lkml.org/lkml/2006/10/19/17
Submitter  : David Miller <davem@davemloft.net>
Caused-By  : Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>
             commit b5e4efe7e061ff52ac97b9fa45acca529d8daeea
Handled-By : Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>
Patch      : http://lkml.org/lkml/2006/10/23/31
Status     : patch available


Subject    : CONFIG_X86_VISWS=y, CONFIG_SMP=n compile error
References : http://lkml.org/lkml/2006/10/7/51
Submitter  : Jesper Juhl <jesper.juhl@gmail.com>
Caused-By  : David Howells <dhowells@redhat.com>
             commit 7d12e780e003f93433d49ce78cfedf4b4c52adc5
Handled-By : Andrey Panin <pazke@donpac.ru>
Patch      : http://lkml.org/lkml/2006/10/23/118
Status     : patch available


Subject    : DVB frontend selection causes compile errors
References : http://lkml.org/lkml/2006/10/8/244
Submitter  : Adrian Bunk <bunk@stusta.de>
Caused-By  : "Andrew de Quincey" <adq_dvb@lidskialf.net>
             commit 176ac9da4f09820a43fd48f0e74b1486fc3603ba
Handled-By : Trent Piepho <xyzzy@speakeasy.org>
Patch      : http://lkml.org/lkml/2006/10/14/157
Status     : patch available



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUBSCao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267687AbUBSCan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:30:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:44174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267683AbUBSCaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:30:35 -0500
Date: Wed, 18 Feb 2004 18:23:13 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kjo <kernel-janitors@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, kaos@ocs.com.au
Subject: reference_init.pl for Linux 2.6
Message-Id: <20040218182313.7b7b915e.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have updated Keith Owens "reference_init.pl" script for
Linux 2.6.  It searches for code that refers to other code
sections that they should not reference, such as init code
calling exit code or v.v.

The script searches all .o (non-MODULE) files in the current
directory and sub-directories.  To restrict its scope, just
'cd drivers/video', e.g., to run it.

Notes:  __devinit and __devexit don't mean/do anything if
CONFIG_HOTPLUG=y, so setting CONFIG_HOTPLUG=n and doing a
'make allyesconfig && make all' finds the most possible
problems.  I say 'possible' because there are probably some
false positives reported.

script for Linux 2.6 is at:
http://developer.osdl.org/rddunlap/scripts/reference_init26.pl

and output from Linux 2.6.3 is at:
http://developer.osdl.org/rddunlap/scripts/badrefs.out

Comments/corrections welcome.

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/

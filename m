Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271932AbTG2RIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271929AbTG2RH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:07:59 -0400
Received: from zeus.kernel.org ([204.152.189.113]:9608 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S271923AbTG2RH6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:07:58 -0400
Date: Tue, 29 Jul 2003 09:42:18 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Frank =?ISO-8859-1?Q?Sch=E4fer?= <Frank.Schafer@setuza.cz>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Simple module question
Message-Id: <20030729094218.580c4644.rddunlap@osdl.org>
In-Reply-To: <1059472604.1109.6.camel@ADMIN.setuza.cz>
References: <1059472604.1109.6.camel@ADMIN.setuza.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 2003 11:56:33 +0200 Frank Schäfer <Frank.Schafer@setuza.cz> wrote:

| Hi list,
| 
| We have a monolithic kernel 2.4.18 using ip-tables. The ftp contrack
| module takes a optional parameter port=xxxxx.
| 
| This parameter should be puttable by the kernel parameters. So I put it
| on the addons line in lilo.conf.
| 
| The parameter doesn't show up in the boot dmesg, I can see it in
| /proc/cmdline, but it doesn't seem to work. No ftp connection can be
| made on this port.
| 
| Could anzbody put me a hint?

The module option is "ports", not "port".

Recent 2.5/2.6 makes kernel or module parameters be usable at module
load time or kernel load time (as a kernel boot parameter).
However, 2.4.x does not do this.  In 2.4.x, each module that wants
to allow module or kernel boot parameters must have explicit code
to support this, but ip_conntrack_ftp.c only has support for
module load time parameters.

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |

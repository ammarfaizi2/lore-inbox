Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTHGP3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270081AbTHGP2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:28:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:64977 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269981AbTHGP06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:26:58 -0400
Date: Thu, 7 Aug 2003 08:22:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Russell Whitaker <russ@ashlandhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.0: lp not working
Message-Id: <20030807082248.3c08c9ac.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0308070222360.357@bigred.russwhit.org>
References: <20030806130452.722d7fb2.rddunlap@osdl.org>
	<20030806223820.5578d282.rddunlap@osdl.org>
	<Pine.LNX.4.53.0308070222360.357@bigred.russwhit.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003 02:31:53 -0700 (PDT) Russell Whitaker <russ@ashlandhome.net> wrote:

| On Wed, 6 Aug 2003, Randy.Dunlap wrote:
| 
| > | Date: Tue, 5 Aug 2003 22:43:17 -0700 (PDT)
| > | From: Russell Whitaker <russ@ashlandhome.net>
| > | To: linux-kernel@vger.kernel.org
| > | Subject: 2.6.0: lp not working
| > |
| > |
| > | Hi
| > | Edited lilo.conf so I can boot either kernel-2.6.0-test2
| > | (default) or kernel-2.4.21, using hda1.
| > |
| > | lpr a small file, no print. ctrl-alt-del and rebooted using
| > | 2.4.21, file printed. Checked the two config files and could
| > | not find any difference in this area.
| > |
| > | Printer is a Panasonic dot-matrix running in text mode.
| > | Also using patch bk5.
| >
| > Is "Parallel Printer support" built into your kernel or built as a
| > module?  If built as a module, are you sure that the module is
| > loaded?  If modular, please provide contents of /proc/modules
| > when you try to print.
| >
| Built as a module
| Found lp.ko in /lib/modules/2.6.0-test2-bk4/kernel/drivers/char
| lp <file> then lpq shows <file> in queue
| 
| contents of /proc/modules
| ipt_LOG 5376 1 - Live 0xf891a000
| ipt_limit 2496 1 - Live 0xf8915000
| ipt_state 1792 2 - Live 0xf8913000
| iptable_filter 2752 1 - Live 0xf88d3000
| ip_tables 22080 4 ipt_LOG,ipt_limit,ipt_state,iptable_filter, Live 0xf88d8000
| ip_conntrack_ftp 72308 0 - Live 0xf88fe000
| ip_conntrack 43092 2 ipt_state,ip_conntrack_ftp, Live 0xf88df000
| ide_cd 41536 0 - Live 0xf88ba000
| cdrom 35168 1 ide_cd, Live 0xf88c6000

I guess I don't get it.  Why isn't "lp" listed in /proc/modules?
Did you load it or is that the problem -- that it's not being
auto-loaded?
Does the <file> print if you load the lp module?

--
~Randy				For Linux-2.6, see:
http://www.kernel.org/pub/linux/kernel/people/davej/misc/post-halloween-2.5.txt

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTLPUGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 15:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTLPUGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 15:06:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:1408 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262283AbTLPUGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 15:06:45 -0500
Date: Tue, 16 Dec 2003 12:05:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: covici@ccs.covici.com, linux-kernel@vger.kernel.org
Subject: Re: dmesg problem in 2.5.73
Message-Id: <20031216120547.0d3b77e2.rddunlap@osdl.org>
In-Reply-To: <1057228803.5499.243.camel@workshop.saharacpt.lan>
References: <m3he64c7qo.fsf@ccs.covici.com>
	<1057228803.5499.243.camel@workshop.saharacpt.lan>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Jul 2003 12:40:04 +0200 Martin Schlemmer <azarah@gentoo.org> wrote:

| On Thu, 2003-07-03 at 10:52, John Covici wrote:
| > Hi.  I have a weird problem -- maybe its iptables, but I am using the
| > log target and they print at legvel 4, but I only want level 3 or
| > less to print on the console, so I did 'dmesg -n 3' but I am still
| > getting the iptables messages.
| > 
| > I thought I could do this all with syslog.conf, but that has never
| > worked.
| > 
| 
| Changing DEFAULT_CONSOLE_LOGLEVEL (?) has been broken since
| 2.5.70 or 2.5.71.  I checked kernel/printk.c, etc, but could
| not see anything that was causing this.

Hi,

Is this still broken?  How do you test it?

In 2.6.0-testN I can change [current] console_loglevel via:

echo 7 > /proc/sysrq-trigger
or
Alt-SysRq-8
or
echo "9 4 1 7" > /proc/sys/kernel/printk

The latter form can also change any of
  (current console_loglevel, default_message_loglevel,
   minimum_console_loglevel, default_console_loglevel}
and is the only way that I know of to change the latter 3 of these.


--
~Randy
MOTD:  Always include version info.

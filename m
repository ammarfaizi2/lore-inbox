Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTJNVOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTJNVOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:14:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:50876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262120AbTJNVO1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:14:27 -0400
Date: Tue, 14 Oct 2003 14:13:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Karel =?ISO-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Vortex full-duplex doesn't work?
Message-Id: <20031014141319.06885762.rddunlap@osdl.org>
In-Reply-To: <20031014230923.D2935@beton.cybernet.src>
References: <20031014223109.A7167@beton.cybernet.src>
	<20031014140216.21cf33a3.rddunlap@osdl.org>
	<20031014230923.D2935@beton.cybernet.src>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003 23:09:23 +0200 Karel Kulhavý <clock@twibright.com> wrote:

| > | Hello
| > | 
| > | I have collected from tidbits of information that
| > | ether=0,0,0x201,0,eth0 should set my 3c900 card to full duplex AUI.
| > | 
| > | I have tried this, then ifconfig eth0 up and then
| > | vortex-diag -vv and it still reports MAC Settings: half-duplex
| > | 
| > | When I rewrite all occurences of full_duplex in 3c59x.c for hard-coded
| > | "1", then I get MAC Settings: full-duplex
| > | 
| > | How do I set up this driver to force full-duplex AUI for 3c900 network
| > | card without using modules and without patching 3c59x.c?
| > 
| > BTW, what kernel version ???
| 
| 2.4.22
| 
| > As I indicated in another reply to you, <quote>
| > Please try this, although I'm not yet convinced that the 3c59x
| > driver calls all of the right hooks for this to work.
| > but good luck, and please report back on it. </quote>
| 
| So the only possibility apart from introducing modules is hacking it up in the
| driver?

Yes, I believe so.

| I tried the 3Com setup DOS diskette and it refuses to set full duplex
| together with AUI.

That makes sense.  Fdx requires 2 copper wire pairs.  AUI is a shared
wire medium.

--
~Randy

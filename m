Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUBJPvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 10:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUBJPvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 10:51:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:52101 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265898AbUBJPvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 10:51:22 -0500
Date: Tue, 10 Feb 2004 07:44:50 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: dick.streefland@altium.nl (Dick Streefland)
Cc: spam@altium.nl, linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
Message-Id: <20040210074450.3adcefdc.rddunlap@osdl.org>
In-Reply-To: <2e79.4028dd7d.6ae8c@altium.nl>
References: <20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk>
	<200402061122.i16BMZ10009537@cherrypit.pdx.osdl.net>
	<20040206113305.GF21151@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0402060850380.30672@home.osdl.org>
	<20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0402061041190.30672@home.osdl.org>
	<2e79.4028dd7d.6ae8c@altium.nl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004 13:32:45 -0000 spam@altium.nl (Dick Streefland) wrote:

| Linus Torvalds <torvalds@osdl.org> wrote:
| | On Fri, 6 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
| | > 
| | > Umm...  How about
| | > 
| | > static inline void BUG() __attribute__((noreturn));
| | > 
| | > static inline void BUG(void)
| | > {
| | > 	__asm__ ....
| | > }
| | 
| | Did you try that? Last time I tried, gcc would complain every time it saw 
| | the thing about "noreturn function does return".
| 
| So, make sure it won't return ;-)
| 
| static inline void BUG(void)
| {
|         __asm__ ("1: jmp 1b");
|         BUG();
| }

doesn't that sorta miss the BUG output?

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/

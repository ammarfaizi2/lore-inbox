Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTJUSRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 14:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbTJUSRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 14:17:31 -0400
Received: from [65.172.181.6] ([65.172.181.6]:48289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263263AbTJUSR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 14:17:29 -0400
Date: Tue, 21 Oct 2003 11:15:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ian <brooke@jump.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Panic with mounting CD in 2.6.0test8
Message-Id: <20031021111536.50b0a6cc.rddunlap@osdl.org>
In-Reply-To: <3F95227C.6080601@jump.net>
References: <3F95227C.6080601@jump.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003 07:11:40 -0500 Ian <brooke@jump.net> wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| I'm getting a kernel panic in running 2.6.0test8 which I just compiled
| today.
| After chatting this up with #Kernelnewbies, erikm told me to post here.
| 
| http://www.gastronomicon.org/im003116.jpg
| 
| Attempt to mount a particular CD, which I'm thinking is just an ordinary
| data CD.
| It could be a VCD, but then I would suspect it would play on my DVD player.
| Windows sees it as a data disk with one big AVI file on it.
| Anyway, I was impressed by the magical symbol lookups in the crash dump,
| but I really just want to mount my CD.
| 
| I am not subscribed to this list, so please CC me on any correspondence.
| I will gladly help debug this.

So you can open/explore the CD in Windows?

The call stack could have scrolled off of the top of the screen.
If not, then cdrom_start_read() called cdrom_start_packet_command(),
but there's not enough info to see what went haywire in
cdrom_start_packet_command() or whether that latter function
called cdrom_start_read_continuation() which then erred or if
it called something which fumbled.  So if you can get more/better
info (from kernel log or serial console etc.), that would be very
helpful.

--
~Randy

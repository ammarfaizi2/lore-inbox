Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbSI3MrZ>; Mon, 30 Sep 2002 08:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSI3MrY>; Mon, 30 Sep 2002 08:47:24 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:60410 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262045AbSI3MrY>; Mon, 30 Sep 2002 08:47:24 -0400
Subject: Re: v2.6 vs v3.0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, james <jdickens@ameritech.net>,
       Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Larry Kessler <kessler@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
In-Reply-To: <20020930075625.GH1014@suse.de>
References: <Pine.LNX.4.44.0209291040420.2240-100000@home.transmeta.com>
	<1033323866.13762.1.camel@irongate.swansea.linux.org.uk> 
	<20020930075625.GH1014@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 13:58:21 +0100
Message-Id: <1033390701.16266.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 08:56, Jens Axboe wrote:
> 2.5 at least does not have the taskfile hang, because I killed taskfile
> io.

Thats not exactly a fix 8). 2.5 certainly has the others. Taskfile I/O
is pretty low on my fix list. The fix isnt trivial because we set the
IRQ handler late - so the IRQ can beat us setting the handler, but
equally if we set it early we get to worry about all the old races in
2.3.x


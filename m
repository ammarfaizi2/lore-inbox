Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132713AbRDIKZY>; Mon, 9 Apr 2001 06:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132715AbRDIKZP>; Mon, 9 Apr 2001 06:25:15 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:24456 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132713AbRDIKZK>; Mon, 9 Apr 2001 06:25:10 -0400
Date: Mon, 9 Apr 2001 12:02:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <20010408221123.A22893@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.3.96.1010409115004.9470B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Apr 2001, Ivan Kokshaysky wrote:

> Of course. I meant that if you are reading, for example, some status register
> in a loop waiting for "ready bit" set, the memory barrier won't help you
> to notice this event any faster. Actually you'll notice that *later*, as
> "mb" is expensive.

 I think you need an mb here.  To force sychronization with other CPUs.
Unless you know you are UP or there is no possibility another CPU may
access the relevant device.

 Of course mbs hit performance but it's a trade off for coherency. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


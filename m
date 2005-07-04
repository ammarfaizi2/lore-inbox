Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVGDHVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVGDHVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 03:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVGDHVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 03:21:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63961 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261561AbVGDHQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 03:16:58 -0400
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re:
	[ltp] IBM HDAPS Someone interested? (Accelerometer))
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Lenz Grimmer <lenz@grimmer.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050704063741.GC1444@suse.de>
References: <9a8748490507031832546f383a@mail.gmail.com>
	 <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de>
	 <42C8C978.4030409@linuxwireless.org>  <20050704063741.GC1444@suse.de>
Content-Type: text/plain
Date: Mon, 04 Jul 2005 09:16:41 +0200
Message-Id: <1120461401.3174.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This is exactly what I said. Use hdparm to make the HD park 
> > inmediatelly. I did send the email to the HDPARM developer, but he never 
> > replied. I asked him what would be the best way to make the HD park with 
> > no exception and then let it come back 5 or 10 seconds later.
> 
> IIRC, you don't have to do anything to wake up the drive after a
> STANDBYNOW command, if you want to be on the safe side you just issue an
> IDLEIMMEDIATE. So your code will look something like:

the problem for this will be that this app will also want to prevent ANY
io going to the disk for a few seconds.

I mean, what use is parking the head if you notice the laptop falling,
when the kernel submits IO to it and wakes it up again before it hits
the ground :)



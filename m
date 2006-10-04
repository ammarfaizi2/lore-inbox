Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWJDHg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWJDHg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWJDHg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:36:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2964 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161117AbWJDHgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:36:25 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Arjan van de Ven <arjan@infradead.org>
To: Jouni Malinen <jkmaline@cc.hut.fi>
Cc: Jean Tourrilhes <jt@hpl.hp.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Jeff Garzik <jeff@garzik.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
In-Reply-To: <20061004022100.GC6110@jm.kir.nu>
References: <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
	 <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com>
	 <1159890876.20801.65.camel@mindpipe>
	 <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
	 <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org>
	 <20061003183849.GA17635@bougret.hpl.hp.com>
	 <d120d5000610031208i4a204b2es8de8d424a573acf4@mail.gmail.com>
	 <20061003194957.GB17855@bougret.hpl.hp.com>
	 <20061004022100.GC6110@jm.kir.nu>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 04 Oct 2006 09:33:23 +0200
Message-Id: <1159947203.3000.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 19:21 -0700, Jouni Malinen wrote:
> On Tue, Oct 03, 2006 at 12:49:57PM -0700, Jean Tourrilhes wrote:
> 
> > 	No, it's not. But as soon as *some part* of WE-21 appears in
> > the kernel, the userspace expect the ESSID change. If we want to have
> > WE-21 without the ESSID change, we need to fix userspace.
> 
> Or leave WIRELESS_EXT at 20 and come up with a new way of versioning any
> future changes in WE.. Yes, having two different mechanisms for version
> number is ugly, but it could prevent userspace breakage.
> 
> (And based on the other messages in this thread, it might be useful to
> include the userspace program's idea of the version in those new
> commands to allow multiple interface versions to be supported by the
> kernel).


or... don't use a NUMBER for this.

If you have a bitmap for supported features, it's much more powerful!
That way you can even do this per driver/hardware, and you can
add/retract individual capabilities rather than lumping everything into
one big number.



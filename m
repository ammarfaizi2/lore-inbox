Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVA3Qso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVA3Qso (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 11:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVA3Qso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 11:48:44 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:49359 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261726AbVA3Qpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 11:45:43 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jesse Pollard <jesse@cats-chateau.net>,
       linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050126191501.GA26920@suse.de>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>
	 <41F6A45D.1000804@comcast.net>
	 <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com>
	 <05012609151500.16556@tabby>
	 <Pine.LNX.4.58.0501260803360.2362@ppc970.osdl.org>
	 <20050126191501.GA26920@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106856939.14787.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 30 Jan 2005 15:39:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-26 at 19:15, Olaf Hering wrote:
> And, did that nice interface help at all? No, it did not.
> Noone made seqfile mandatory in 2.6.
> Now we have a few nice big patches to carry around because every driver
> author had its own proc implementation. Well done...

seqfile has helped immensely from what I can see. And gradually it takes
over the kernel because each time someone has a broken proc driver it is
easier to rewrite it in seq_file than fix it any other way.

All good API's work that way, and they really do work. You only have to
look at things like the statistics for Gnome application string caused
security errors versus those for generic C apps to see the huge effect
stuff like g_string classes have had on reliability.

We need *more* API's like this - we are lacking some nice helpers for
simple block/char devices and also lacking a "call under lock" construct
which avoids forgetting to drop locks for example.

Alan


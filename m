Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWFFJIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWFFJIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 05:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWFFJIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 05:08:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47825 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750742AbWFFJIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 05:08:52 -0400
Subject: Re: [PATCH 8/11] usbserial: pl2303: Ports tty functions.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20060606073441.GD17682@suse.de>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	 <1149217398434-git-send-email-lcapitulino@mandriva.com.br>
	 <20060602205014.GB31251@suse.de>
	 <20060602154121.d3f19cbe.zaitcev@redhat.com>
	 <20060602224435.GA26061@suse.de> <20060603191917.29967d61@home.brethil>
	 <20060606073441.GD17682@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Jun 2006 10:23:28 +0100
Message-Id: <1149585808.5724.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > | > > >   2. The new pl2303's set_termios() can (still) sleep. Serial Core's
> > | > > >      documentation says that that method must not sleep, but I couldn't find
> > | > > >      where in the Serial Core code it's called in atomic context. So, is this
> > | > > >      still true? Isn't the Serial Core's documentation out of date?

For the tty layer at least this was fixed to be semaphore locked and I
think this is now a docs error. It was fixed precisely because the USB
people couldn't resolve termios setup without sleeping.


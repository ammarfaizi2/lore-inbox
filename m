Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbUK3Noq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbUK3Noq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUK3Noq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:44:46 -0500
Received: from canuck.infradead.org ([205.233.218.70]:35845 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262067AbUK3Nop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:44:45 -0500
Subject: Re: [RFC] relinquish_fs() syscall
From: Arjan van de Ven <arjan@infradead.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041130132744.GB63669@gaz.sfgoth.com>
References: <20041129114331.GA33900@gaz.sfgoth.com>
	 <1101729087.20223.14.camel@localhost.localdomain>
	 <20041129135559.GC33900@gaz.sfgoth.com>
	 <1101741440.20225.22.camel@localhost.localdomain>
	 <20041130132744.GB63669@gaz.sfgoth.com>
Content-Type: text/plain
Message-Id: <1101822273.2640.52.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 14:44:33 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 05:27 -0800, Mitchell Blank Jr wrote:
> Alan Cox wrote:
> > With CAP_SYS_RAWIO I can ask the IDE controller to DMA into the kernel
> > as one example.
> 
> Can you really do that on normal file descriptors?  Weird.  I'd have thought
> you'd need to open /dev/hd* to do that.

inb/outb after iopl.


> Is AF_UNIX in a separate namespace?  My understanding (from reading
> unix_find_other()) is that unless you can create a UNIX socket in your
> filesystem you're going to have trouble creating new UNIX sockets.

iirc there are anonymous unix sockets...


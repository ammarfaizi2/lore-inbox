Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUI1WPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUI1WPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268079AbUI1WNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:13:24 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:681 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S268072AbUI1WJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:09:12 -0400
Subject: Re: mlock(1)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrea Arcangeli <andrea@novell.com>
Cc: Stefan Seyfried <seife@suse.de>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040927224345.GB2412@dualathlon.random>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net>
	 <1096071873.3591.54.camel@desktop.cunninghams>
	 <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de>
	 <20040927141652.GF28865@dualathlon.random>
	 <1096323761.3606.3.camel@desktop.cunninghams>
	 <20040927224345.GB2412@dualathlon.random>
Content-Type: text/plain
Message-Id: <1096409035.2116.3.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 29 Sep 2004 08:03:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-09-28 at 08:43, Andrea Arcangeli wrote:
> On Tue, Sep 28, 2004 at 08:22:41AM +1000, Nigel Cunningham wrote:
> > > I figured out how to make the swap encryption completely transparent to
> > > userspace, and even to swap suspend, so I think it's much better than
> > > having userspace asking the user for a password, or userspace choosing a
> > > random password.
> > 
> But why did you quote the above? for cryptoswap it cannot work, for
> cryptoswap there's no reason to ever ask the user to anything and it
> must read and write all the time anyways, it's not like suspend
> write-only and resume read-only, a problem where public/private
> encryption can fit.

I think I was a bit confused. Sorry.

> > > yes, but the bootloader passes the paramters via /proc/cmdline, and it's
> > > not nice to show the password in cleartext there.
> > 
> > If this password is only needed when resuming, that's not an issue
> > because the command line given when resuming will be lost when the
> > original kernel data is copied back.
> 
> my point is that you would not be allowed to give anyone ssh access to
> your machine (assuming you trust local security). If he gets ssh access,
> then he could as well stole the laptop and read the encrypted data.

Don't follow, sorry. Perhaps I'm being thick!

> But if calling set_fs(KERNEL_DS); sys_read(0) sounds troublesome, you
> could also erase the password from the cmdline, and you would still
> pass the passphrase via bootloader. I'd recommend not to make it visible
> to userspace.
> 
> > There's already compression support. It's simpler to reverse, of course,
> > but it doesn't help?
> 
> that should be trivial to reverse, no?

Yes, it would be.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.


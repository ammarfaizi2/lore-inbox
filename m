Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbUAHNFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbUAHNFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:05:22 -0500
Received: from f19.mail.ru ([194.67.57.49]:25363 "EHLO f19.mail.ru")
	by vger.kernel.org with ESMTP id S264457AbUAHNFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:05:16 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Greg KH=?koi8-r?Q?=22=20?= <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Thu, 08 Jan 2004 16:05:15 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AeZqd-000NMl-00.arvidjaar-mail-ru@f19.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > >  2) We are (well, were) running out of major and minor numbers for
> > >     devices.
> > 
> > devfs tried to fix this one by _getting rid_ of those numbers.
> > Seriously - what are they needed for?  
>
> But devfs failed in this.  The devfs kernel interface still requires a
> major/minor number to create device nodes.
>
> Hopefully I can work on fixing this up in 2.7.

You must be kidding here. Where exactly do you see devfs fault?

It is not "devfs kernel interface". It is "kernel userland interface"
that requires a major/minor to associate device node with device.

Devfs (in its current shape) is no more than just a repository of
(device node, major/minor) relations. Devfs does not care where
dev number comes from. Driver may hardcode it or request
dynamically from kernel, either way is fine.

Answering your other mail - "devfs kernel interface" provided ability
to request dynamic device number when registering a node. Sounds
very much like what you'd wish. Somebody decided it was evil and
removed it. I personally do not care either way.

regards

-andrey

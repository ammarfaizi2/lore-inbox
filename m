Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753074AbWKFN0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbWKFN0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbWKFN0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:26:23 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1489 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1753074AbWKFN0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:26:23 -0500
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wilco Beekhuizen <wilcobeekhuizen@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Nov 2006 13:30:51 +0000
Message-Id: <1162819851.1566.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-11-06 am 12:38 +0100, ysgrifennodd Wilco Beekhuizen:
> Including PCI_ANY_ID again fixes these problems but is of course a
> pretty evil fix. The problem is I can't find out which PCI ids to
> include. I'm new to this list so suggestions are welcome.

As far as I can make out the correct answer is "none", and then fix the
actual problems in the boxes that need these workarounds. They break as
much if not more than they cure.

Please boot your system without the workarounds (ie a current kernel).
Then do lspci -vxxx and save that to a file. Then go back to a kernel
with working networking and email me and/or the list that result.

>From that I can take a look at what we've actually got set up for IRQ
routing and try to work out why it might not be working and how we got
where we did.

Alan

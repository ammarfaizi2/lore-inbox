Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280379AbRJaSNw>; Wed, 31 Oct 2001 13:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280382AbRJaSNm>; Wed, 31 Oct 2001 13:13:42 -0500
Received: from air-1.osdl.org ([65.201.151.5]:65291 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S280379AbRJaSN3>;
	Wed, 31 Oct 2001 13:13:29 -0500
Message-ID: <3BE03DCA.8E662B80@osdl.org>
Date: Wed, 31 Oct 2001 10:07:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: krajput@softhome.net, linux-kernel@vger.kernel.org
Subject: Re: Oops msg after upgrading to 2.4.10
In-Reply-To: <E15ysst-0003Fg-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I have tried to upgrade my Linux 7.1 (kernel version 2.4.2) to kernel
> > version 2.4.10 but to no avail. The kernel does install but fails to load
> > the USB uhci subsytem. Infact when i do "lsmod" after the upgrade it shows
> > me an empty table. Here are the steps that i undertook for the total
> > upgrade
> 
> You need the -ac tree for working USB locking, even as of 2.4.14pre
> -

However, this 2.4.10 oops was probably in usb-uhci and due to a list
management change (smth like: list->prev = list->next = NULL;
on list entry deletion).  It was quickly fixed in usb-uhci in
2.4.11 ("dontuse") and later.

~Randy

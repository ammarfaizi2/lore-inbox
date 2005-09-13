Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVIMFdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVIMFdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVIMFdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:33:13 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:685 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932302AbVIMFdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:33:13 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
Date: Tue, 13 Sep 2005 00:33:10 -0500
User-Agent: KMail/1.8.2
Cc: Jiri Slaby <jirislaby@gmail.com>, Lion Vollnhals <lion.vollnhals@web.de>
References: <200509130010.38483.lion.vollnhals@web.de> <43260817.7070907@gmail.com> <84144f0205091221431827b126@mail.gmail.com>
In-Reply-To: <84144f0205091221431827b126@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509130033.11109.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 23:43, Pekka Enberg wrote:
> On 9/13/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> > >-      cls = kmalloc(sizeof(struct class), GFP_KERNEL);
> > >+      cls = kzalloc(sizeof(struct class), GFP_KERNEL);
> > >
> > >
> > maybe, the better way is to write `*cls' instead of `struct class',
> > better for further changes
> 
> Please note that some maintainers don't like it. I at least could not
> sneak in patches like these to drivers/usb/ because I had changed
> sizeof.
> 

And given the fact that Greg maintains driver core it probably won't be
accepted here either :)

FWIW I also prefer spelling out the structure I am allocating.

-- 
Dmitry

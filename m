Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUBNJN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 04:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUBNJN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 04:13:57 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:460 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261500AbUBNJN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 04:13:56 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>
Subject: Re: devfs vs udev, thoughts from a devfs user
Date: Sat, 14 Feb 2004 10:13:50 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040213211920.GH14048@kroah.com> <20040214085110.GG5649@tinyvaio.nome.ca>
In-Reply-To: <20040214085110.GG5649@tinyvaio.nome.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402141013.50633.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Bell wrote:
> On Fri, Feb 13, 2004 at 01:19:20PM -0800, Greg KH wrote:
> > > That's a pretty minor difference, from the kernel's point of view.
> > > It's basically putting the same numbers in different fields.
> >
> > Heh, that's a HUGE difference!
>
> Only from userspace's point of view. To the kernel, it's basically the
> same thing.

No. Giving a major and minor number is simple. 
Creating a device node means: you have to define a policy. Now the kernel 
has to think about:
- user id
- group id
- access rights
- naming

These are the reasons why devfsd was/is necessary for devfs.
A Kernel should only enforce a policy, it should not define it.

cheers

Christian


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbUL0Pjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbUL0Pjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUL0Pjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:39:44 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:12170 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261910AbUL0Pia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:38:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=of+zfGctj1BER9+84+frQCGf/LZE4UD3rS9vT/hNle+9Z/dISY7VyFGzQgRrN09s1jA8osh3n62h2dIQzvljt240JB1P3bGtafk9j1yN15SlvOe/Xxn3yO51cFVJbbE3dJUwMXZEQ6srkORNuE8TdhhchBAz0rY3UXoeWn8NcO0=
Message-ID: <58cb370e0412270738fbc045c@mail.gmail.com>
Date: Mon, 27 Dec 2004 16:38:30 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Ross Biro <ross.biro@gmail.com>
Subject: Re: Linux 2.6.10-ac1
Cc: Andreas Steinmetz <ast@domdv.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <8783be660412270645717b89d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104103881.16545.2.camel@localhost.localdomain>
	 <58cb370e04122616577e1bd33@mail.gmail.com> <41CF649E.20409@domdv.de>
	 <58cb370e041226174019e75e23@mail.gmail.com>
	 <8783be660412270645717b89d1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 09:45:54 -0500, Ross Biro <ross.biro@gmail.com> wrote:
> On Mon, 27 Dec 2004 02:40:45 +0100, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> > On Mon, 27 Dec 2004 02:25:50 +0100, Andreas Steinmetz <ast@domdv.de> wrote:
> > > Bartlomiej Zolnierkiewicz wrote:
> > > > What do you need 'serialize' option for?
> >
> > No, I want them to fix the problem - whenever it is - ide or apic code. :)
> 
> And what do you want them to do when the problem is in hardware?

Workaround it if it is possible.  If this is really a unfixable hardware problem
(hard to believe - other OS-es would be also bitten by the issue) shouldn't it
be workaround differently anyway by something like "ide=serialize_all" (which
is much saner from IDE POV than "idex=serialize") ?

The reason I want to remove some of IDE options is that otherwise I have to
add ~ 200 lines of ugly code for storing them in the temporary buffer (part of
dynamic ide_hwifs[] patch) and it still is wrong...

IDE option -> IDE core -> IDE host driver

while it really should be

IDE option -> IDE host driver

Bartlomiej

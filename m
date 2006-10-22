Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWJVStn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWJVStn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWJVStn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:49:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:45812 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750819AbWJVStl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:49:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Date: Sun, 22 Oct 2006 20:49:36 +0200
User-Agent: KMail/1.9.5
Cc: Christoph Hellwig <hch@infradead.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <4537818D.4060204@qumranet.com> <200610222036.03455.arnd@arndb.de> <453BBB41.4070905@qumranet.com>
In-Reply-To: <453BBB41.4070905@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610222049.36338.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 20:41, Avi Kivity wrote:
> > Ok, but if you radically change the kernel<->user API, doesn't that mean
> > you have to upgrade in the same way?
>
> No, why? I'd just upgrade the userspace.  Am I misunderstanding you?

If you change the kernel interface, you also have to change the kernel
itself, at least if you introduce new syscalls.

> > The 32 bit emulation mode in x86_64
> > is actually pretty complete, so it probably boils down to a kernel
> > upgrade for you, without having to touch any of the user space.
> >  
>
> For me personally, I don't mind.  I don't know about others.

I'd really love to see your code in get into the mainline kernel,
but I'd consider 32 bit host support an unnecessary burden for
long-term maintenance. Maybe you could maintain the 32 bit version
out of tree as long as there is still interest? I would expect that
at least the point where it works out of the box on x86_64
distros is when it becomes completely obsolete.

	Arnd <><

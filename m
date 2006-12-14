Return-Path: <linux-kernel-owner+w=401wt.eu-S932633AbWLNLbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWLNLbU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWLNLbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:31:20 -0500
Received: from www.osadl.org ([213.239.205.134]:50991 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932633AbWLNLbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:31:19 -0500
From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Thu, 14 Dec 2006 12:31:16 +0100
User-Agent: KMail/1.9.5
Cc: "Hua Zhong" <hzhong@gmail.com>, "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>, "'Greg KH'" <gregkh@suse.de>,
       "'Jonathan Corbet'" <corbet@lwn.net>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
References: <4580E37F.8000305@mbligh.org> <003801c71f45$45d722c0$6721100a@nuitysystems.com> <20061214111439.11bed930@localhost.localdomain>
In-Reply-To: <20061214111439.11bed930@localhost.localdomain>
Organization: Linutronix
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141231.17331.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2006 12:14 schrieb Alan:
> On Wed, 13 Dec 2006 22:01:15 -0800
> "Hua Zhong" <hzhong@gmail.com> wrote:
> 
> > > I think allowing binary hardware drivers in userspace hurts 
> > > our ability to leverage companies to release hardware specs. 
> > 
> > If filesystems can be in user space, why can't drivers be in user space? On what *technical* ground?
> 
> The FUSE file system interface provides a clean disciplined interface
> which allows an fs to live in user space. The uio layer (if its ever
> fixed and cleaned up) provides some basic hooks that allow a user space
> program to arbitarily control hardware and make a nasty undebuggable mess.

You think it's easier for a manufacturer of industrial IO cards to
debug a (large) kernel module?

> 
> uio also doesn't handle hotplug, pci and other "small" matters.

uio is supposed to be a very thin layer. Hotplug and PCI are already
handled by other subsystems. 

> 
> Now if you wanted to make uio useful at minimum you would need
> 

The majority of industrial IO cards have registers and/or dual port RAM
that can be mapped to user space (even today). We want to add a simple
way to handle interrupts for such cards. That's all.
The fact that there might be some sort of hardware/interrupts/situations
where this is not possible or not so simple isn't that important at the
moment. We can extend the UIO system if somebody actually requires these
extensions.

Hans


Return-Path: <linux-kernel-owner+w=401wt.eu-S932702AbWLNMyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWLNMyb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbWLNMyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:54:31 -0500
Received: from www.osadl.org ([213.239.205.134]:60248 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932702AbWLNMya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:54:30 -0500
From: =?utf-8?q?Hans-J=C3=BCrgen_Koch?= <hjk@linutronix.de>
Organization: Linutronix
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Thu, 14 Dec 2006 13:54:24 +0100
User-Agent: KMail/1.9.5
Cc: "Hua Zhong" <hzhong@gmail.com>, "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>, "'Greg KH'" <gregkh@suse.de>,
       "'Jonathan Corbet'" <corbet@lwn.net>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
References: <4580E37F.8000305@mbligh.org> <200612141231.17331.hjk@linutronix.de> <20061214124241.44347df6@localhost.localdomain>
In-Reply-To: <20061214124241.44347df6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612141354.26506.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2006 13:42 schrieb Alan:
> On Thu, 14 Dec 2006 12:31:16 +0100
> Hans-Jürgen Koch <hjk@linutronix.de> wrote:
> > You think it's easier for a manufacturer of industrial IO cards to
> > debug a (large) kernel module?
> 
> You think its any easier to debug because the code now runs in ring 3 but
> accessing I/O space.

For the intended audience, yes.

> 
> 
> > > uio also doesn't handle hotplug, pci and other "small" matters.
> > 
> > uio is supposed to be a very thin layer. Hotplug and PCI are already
> > handled by other subsystems. 
> 
> And if you have a PCI or a hotplug card ? How many industrial I/O cards
> are still ISA btw ?

Who is talking about ISA? All cards we had in mind are PCI. Of course
you have to do the usual initialization work in your probe/release or
init/exit functions. These are just a few lines you find in any
beginners device-driver-writing book. I don't think that the UIO 
framework could simplify that in a sensible way.

Hans


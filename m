Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVFMXCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVFMXCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVFMXAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 19:00:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:7893 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261183AbVFMW6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:58:47 -0400
Subject: Re: Add pselect, ppoll system calls.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, jnf <jnf@innocence-lost.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       drepper@redhat.com
In-Reply-To: <1118647789.2840.0.camel@localhost.localdomain>
References: <1118444314.4823.81.camel@localhost.localdomain>
	 <1118616499.9949.103.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
	 <1118647401.5986.91.camel@gaston>
	 <1118647789.2840.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 14 Jun 2005 08:56:52 +1000
Message-Id: <1118703413.5986.100.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 08:29 +0100, David Woodhouse wrote:
> On Mon, 2005-06-13 at 17:23 +1000, Benjamin Herrenschmidt wrote:
> > That is still racy ... if the signal hits between loading that global to
> > to pass it to select and the actual syscall entry ... pretty narrow but
> > still there.
> 
> We don't load it; we pass a pointer to select. It works, but it's hardly
> elegant.

Argh true, blame my own wrapper to select that takes an ulong ..

Who said POSIX was a crap API ? :)

Ben.



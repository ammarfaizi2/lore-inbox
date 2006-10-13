Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWJMGLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWJMGLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 02:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWJMGLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 02:11:21 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:18612 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1750826AbWJMGLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 02:11:20 -0400
X-Originating-Ip: 72.57.81.197
Date: Fri, 13 Oct 2006 02:10:15 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Roman Zippel <zippel@linux-m68k.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Redefine instances of sema_init() to use standard form.
In-Reply-To: <200610130047.58507.zippel@linux-m68k.org>
Message-ID: <Pine.LNX.4.64.0610130156480.14713@localhost.localdomain>
References: <Pine.LNX.4.64.0610120330540.5013@localhost.localdomain>
 <200610130047.58507.zippel@linux-m68k.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i can't believe a simple cleanup patch has turned into such an
issue.

On Fri, 13 Oct 2006, Roman Zippel wrote:

> Hi,
>
> On Thursday 12 October 2006 09:44, Robert P. J. Day wrote:
>
> > Since there seems to be no compelling reason *not* to do this,
> [..]
> > -	/*
> > -	 * Logically,
> > -	 *   *sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
> > -	 * except that gcc produces better initializing by parts yet.
> > -	 */
>
> You've seen this?

in fact, i did, and i admit that i have no idea what it means to say
that "gcc produces better initializing by parts yet."

there were a number of semaphore.h files whose comments made it clear
that GCC 2.7.2.3 was the *only* reason that the shorter, more direct
form wasn't being used, so it should be clear that those could be
changed.

there was only *one* of those header files (asm-alpha/semaphore.h)
that had the caution above, but i have no idea what "better
initializing" means?

"better" as in faster?  "better" as in more compact?  "better" as in
correct?  i mean, either the shorter, more direct initialization
*works* and produces the same result in this case, or it *doesn't*.
which is it?  or is that note perhaps a holdover from an old version
of gcc as well?

can you clarify what that comment means in the context of the alpha
architecture, and why simplifying the call would actually be a
mistake?

rday

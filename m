Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbUL3FIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbUL3FIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 00:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbUL3FIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 00:08:32 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:16350 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261542AbUL3FHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 00:07:40 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 29 Dec 2004 21:07:36 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Jesse Allen <the3dfxdude@gmail.com>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <20041120214915.GA6100@tesore.ph.cox.net>  <41A251A6.2030205@wanadoo.fr> 
 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>  <1101161953.13273.7.camel@littlegreen>
  <1104286459.7640.54.camel@gamecube.scs.ch>  <1104332559.3393.16.camel@littlegreen>
  <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org> 
 <53046857041229114077eb4d1d@mail.gmail.com>  <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
 <530468570412291343d1478cf@mail.gmail.com> <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004, Linus Torvalds wrote:

> On Wed, 29 Dec 2004, Linus Torvalds wrote:
> > 
> > .. no, I see what's up. System call returns _are_ special for 
> > single-stepping. I'll think about it..
> 
> Ok, I think I know what's up.
> 
> It's literally the bogus fake signal that do_syscall_trace() sends. I 
> think the TIF_SINGLESTEP case in do_syscall_trace() should only do the 
> ptrace_notify() and return..

I think same. My test simply let the function processing to let thru and 
reach the fake signal sending point.


- Davide


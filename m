Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUFFQdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUFFQdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUFFQdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:33:20 -0400
Received: from sphinx.mythic-beasts.com ([212.69.37.6]:4244 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S263795AbUFFQdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:33:19 -0400
Date: Sun, 6 Jun 2004 17:33:06 +0100 (BST)
From: chris@scary.beasts.org
X-X-Sender: cevans@sphinx.mythic-beasts.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Kalin KOZHUHAROV <kalin@ThinRope.net>,
       Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@ximian.com>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0406061725450.28570@sphinx.mythic-beasts.com>
References: <40C1E6A9.3010307@elegant-software.com> 
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> 
 <20040605205547.GD20716@devserv.devel.redhat.com>  <20040605215346.GB29525@taniwha.stupidest.org>
 <1086475663.7940.50.camel@localhost> <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org> <40C2A6E4.7020103@ThinRope.net>
 <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, 5 Jun 2004, Linus Torvalds wrote:

> But no, even despite the strange usage, this isn't a performance issue.
> qmail will call "getpid()" a few tens of times per connection because of
> the wonderful quality of randomness it provides, or something.

The openssl library seems to have a strange love for getpid() too. At
least, my old-ish version "openssl-0.9.6b-35.7" does.
My strace logs show over 50 consecutive getpid() calls during the
processing of the SSL_accept() routine. (I'm adding SSL support to vsftpd;
SSL_accept() is called every client connect and also to accept passive
data connections).

Cheers
Chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUFEX0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUFEX0X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 19:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUFEX0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 19:26:23 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:23940 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262382AbUFEX0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 19:26:21 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 5 Jun 2004 16:26:19 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Robert Love <rml@ximian.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0406051620190.2261@bigblue.dev.mdolabs.com>
References: <40C1E6A9.3010307@elegant-software.com> 
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> 
 <20040605205547.GD20716@devserv.devel.redhat.com>  <20040605215346.GB29525@taniwha.stupidest.org>
 <1086475663.7940.50.camel@localhost> <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2004, Linus Torvalds wrote:

> 
> 
> On Sat, 5 Jun 2004, Davide Libenzi wrote:
> > 
> > It is likely used by pthread_self(), that is pretty much performance 
> > sensitive. I'd agree with Ulrich here.
> 
> It _can't_ be used for pthread_self(), since the pid is the _same_ across 
> all threads in a pthread environment.

Yeah, I just checked. It is not for that. And like Robert was saying, it'd 
have been a gettid().



- Davide


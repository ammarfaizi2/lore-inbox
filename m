Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270179AbTGVN1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270278AbTGVN1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:27:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60166 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270179AbTGVN1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:27:19 -0400
Date: Tue, 22 Jul 2003 14:42:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: sizeof (siginfo_t) problem
Message-ID: <20030722144218.B5838@flint.arm.linux.org.uk>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
References: <20030714084000.J15481@devserv.devel.redhat.com> <20030715025252.17ec8d6f.sfr@canb.auug.org.au> <20030719183254.GE25703@krispykreme> <20030721100819.11584560.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030721100819.11584560.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Mon, Jul 21, 2003 at 10:08:19AM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 10:08:19AM +1000, Stephen Rothwell wrote:
> On Sun, 20 Jul 2003 04:32:54 +1000 Anton Blanchard <anton@samba.org> wrote:
> > > I am not sure if the s390 fix is correct (since s390x has been merged) or
> > > if x86_64 needs this (as I cannot remember the alignment needs of the
> > > x86_64 compiler - though I suspect it is needed).
> > 
> > I didnt follow this thread very carefully :) Is ppc64 broken?
> 
> It is broken subtly (but noone would probably notice :-)).  It is OK
> on the structure size, but copy_siginfo will copy sizeof(int) bytes less
> than necessary sometimes (particularly in the case of a SIGCHILD).

Maybe it'd be a good idea to copy the architecture maintainers.  I'm
certainly deleting a couple of thousand lkml mails at the moment, so
its pretty lucky that I just read Anton's message.

Is ARM broken?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264934AbUFHJvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUFHJvX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUFHJvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:51:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36495 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261993AbUFHJuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:50:39 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Russell Leighton <russ@elegant-software.com>, davidm@hpl.hp.com,
       Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <-> getpid() bug in 2.6?]
References: <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
	<40C32A44.6050101@elegant-software.com>
	<40C33A84.4060405@elegant-software.com>
	<1086537490.3041.2.camel@laptop.fenrus.com>
	<40C3AD9E.9070909@elegant-software.com>
	<20040607121300.GB9835@devserv.devel.redhat.com>
	<6uu0xn5vio.fsf@zork.zork.net> <20040607140009.GA21480@infradead.org>
	<16580.46864.290708.33518@napali.hpl.hp.com>
	<40C4F40A.8060205@elegant-software.com>
	<20040608060129.GD31155@devserv.devel.redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Jun 2004 03:48:11 -0600
In-Reply-To: <20040608060129.GD31155@devserv.devel.redhat.com>
Message-ID: <m1pt8amld0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Mon, Jun 07, 2004 at 07:02:34PM -0400, Russell Leighton wrote:
> > >
> > So Ia64 does have it..that's good. Does glibc wrap it?
> > 
> > I agree with the above...could glibc's clone() should have a size added? 
> > Then the arch specific stack issues
> > could be hidden.
> 
> glibc doesn't provide clone other than a raw syscall wrapper, under the
> assumption that when you want threads, you'll use it's thread creation call.
> Not too unfair imo.

That fn parameter certainly more than a raw wrapper.  I do agree that
what is needed is a fairly raw wrapper though. 

I don't see how creating a clone2 wrapper that drops the extra argument
on platforms that don't use it is any different than what glibc already
does though.

Eric



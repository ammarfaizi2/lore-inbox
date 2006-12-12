Return-Path: <linux-kernel-owner+w=401wt.eu-S1751092AbWLLKDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWLLKDM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 05:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWLLKDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 05:03:11 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49734 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbWLLKDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 05:03:10 -0500
Date: Tue, 12 Dec 2006 10:59:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061212095923.GA32383@elte.hu>
References: <20061204114851.GA25859@elte.hu> <20061201172149.GC3078@ftp.linux.org.uk> <1165064370.24604.36.camel@localhost.localdomain> <20061202140521.GJ3078@ftp.linux.org.uk> <1165070713.24604.50.camel@localhost.localdomain> <20061202160252.GQ14076@parisc-linux.org> <1165082803.24604.54.camel@localhost.localdomain> <20061202181957.GK3078@ftp.linux.org.uk> <28665.1165234964@redhat.com> <20061206002403.GA4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206002403.GA4587@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Al Viro <viro@ftp.linux.org.uk> wrote:

> On Mon, Dec 04, 2006 at 12:22:44PM +0000, David Howells wrote:
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > the question is: which is more important, the type safety of a 
> > > container_of() [or type cast], which if we get it wrong produces a 
> > > /very/ trivial crash that is trivial to fix
> 
> The hell it is.  You get wrong fields of a big struct read and 
> modified. Silently.

yeah - i think you are right. I think we should go with your changes to 
incrase type safety for timer callbacks - and if someone wants to shrink 
size (which patches do not exist at the moment), that person can think 
about how to achieve that while still keeping type safety.

	Ingo

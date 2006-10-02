Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbWJBXxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWJBXxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWJBXxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:53:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:63703 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965092AbWJBXxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:53:07 -0400
Date: Mon, 2 Oct 2006 16:52:46 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Message-ID: <20061002235246.GA27274@kroah.com>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <20061002132116.2663d7a3.akpm@osdl.org> <d120d5000610021343h45bf1414ica2246f3b10ff46d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000610021343h45bf1414ica2246f3b10ff46d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 04:43:38PM -0400, Dmitry Torokhov wrote:
> On 10/2/06, Andrew Morton <akpm@osdl.org> wrote:
> >On Mon, 02 Oct 2006 17:21:09 +0100
> >David Howells <dhowells@redhat.com> wrote:
> >
> >> Maintain a per-CPU global "struct pt_regs *" variable which can be used 
> >instead
> >> of passing regs around manually through all ~1800 interrupt handlers in 
> >the
> >> Linux kernel.
> >>
> 
> Nice! I was wanting to do that for a long time...

Yeah!  Finally get rid of that from every single fricken USB urb
callback.  I have been wanting that gone for a very long time.

> >I think the change is good.  But I don't want to maintain this whopper
> >out-of-tree for two months!  If we want to do this, we should just smash it
> >in and grit our teeth.
> 
> Yes, lets drop it in while we still not reached rc1.

I don't care when it goes it, I have no objection to it at all.

David, thanks a lot for doing this.

greg k-h

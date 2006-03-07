Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWCGRlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWCGRlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWCGRlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:41:00 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:21936 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751417AbWCGRk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:40:59 -0500
Date: Tue, 7 Mar 2006 10:40:57 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, ak@suse.de,
       mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Memory barriers and spin_unlock safety
Message-ID: <20060307174057.GD7301@parisc-linux.org>
References: <5041.1141417027@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org> <32518.1141401780@warthog.cambridge.redhat.com> <1146.1141404346@warthog.cambridge.redhat.com> <31420.1141753019@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31420.1141753019@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 05:36:59PM +0000, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > I suspect, then, that x86_64 should not have an SFENCE for smp_wmb(), and
> > that only io_wmb() should have that.
> 
> Hmmm... We don't actually have io_wmb()... Should the following be added to
> all archs?
> 
> 	io_mb()
> 	io_rmb()
> 	io_wmb()

it's spelled mmiowb(), and reads from IO space are synchronous, so don't
need barriers.

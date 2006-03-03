Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWCCUR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWCCUR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWCCUR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:17:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51431 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932161AbWCCUR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:17:26 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org> 
References: <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>  <32518.1141401780@warthog.cambridge.redhat.com> <1146.1141404346@warthog.cambridge.redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, ak@suse.de,
       mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com, matthew@wil.cx,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Memory barriers and spin_unlock safety 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 03 Mar 2006 20:17:07 +0000
Message-ID: <5041.1141417027@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> Note that _normal_ writes never need an SFENCE, because they are ordered 
> by the core.
> 
> The reason to use SFENCE is because of _special_ writes.

I suspect, then, that x86_64 should not have an SFENCE for smp_wmb(), and that
only io_wmb() should have that.

David

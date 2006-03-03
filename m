Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWCCVey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWCCVey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWCCVey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:34:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54934 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751394AbWCCVex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:34:53 -0500
Date: Fri, 3 Mar 2006 13:34:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, ak@suse.de, mingo@redhat.com, jblunck@suse.de,
       bcrl@linux.intel.com, matthew@wil.cx, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Memory barriers and spin_unlock safety 
In-Reply-To: <5041.1141417027@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603031332140.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org> 
 <32518.1141401780@warthog.cambridge.redhat.com> <1146.1141404346@warthog.cambridge.redhat.com>
  <5041.1141417027@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Mar 2006, David Howells wrote:
> 
> I suspect, then, that x86_64 should not have an SFENCE for smp_wmb(), and that
> only io_wmb() should have that.

Indeed. I think smp_wmb() should be a compiler fence only on x86(-64), ie 
just compile to a "barrier()" (and not even that on UP, of course).

		Linus

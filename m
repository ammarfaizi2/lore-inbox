Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937109AbWLFTG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937109AbWLFTG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760669AbWLFTG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:06:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58200 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759338AbWLFTGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:06:25 -0500
Date: Wed, 6 Dec 2006 11:05:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Christoph Lameter wrote:
>
> I'd really appreciate a cmpxchg that is generically available for 
> all arches. It will allow lockless implementation for various performance 
> criticial portions of the kernel.

I suspect ARM may have been the last one without one, no?

That said, cmpxchg won't necessarily be "high-performance" unless the hw 
supports it naturally in hardware, so..

Russell, are you ok with the code DavidH posted (the "try 2" one)? I'd 
like to get an ack from the ARM maintainer before applying it, but it 
looked ok.

		Linus

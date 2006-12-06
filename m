Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936922AbWLFRXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936922AbWLFRXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936902AbWLFRXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:23:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46398 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936790AbWLFRXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:23:10 -0500
Date: Wed, 6 Dec 2006 09:21:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0612060918480.3542@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, David Howells wrote:
> 
> Implement generic UP cmpxchg() where an arch doesn't otherwise support it.
> This assuming that the arch doesn't have support SMP without providing its own
> cmpxchg() implementation.

This is too ugly to live. At least the kernel/workqueue.c part.

The requirement that everybody implement a workable cmpxchg (and falling 
back to spinlocks if required as per the atomic bit operations) looks ok, 
but don't show that in generic code.

		Linus

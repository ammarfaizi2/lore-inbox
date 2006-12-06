Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937585AbWLFT5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937585AbWLFT5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937583AbWLFT5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:57:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34737 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937578AbWLFT5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:57:41 -0500
Date: Wed, 6 Dec 2006 11:56:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: Al Viro <viro@ftp.linux.org.uk>, Christoph Lameter <clameter@sgi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <Pine.LNX.4.64.0612061152290.3542@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612061155590.3542@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206190828.GE4587@ftp.linux.org.uk>
 <Pine.LNX.4.64.0612061122120.3542@woody.osdl.org> <20061206192939.GX3013@parisc-linux.org>
 <Pine.LNX.4.64.0612061152290.3542@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Linus Torvalds wrote:
> 
> Your problem will be, of course, that any architecture that does this in 
> hardware will just DoTheRightThing, and as such, broken architectures with 
> bad locking primitives will have to test and do source-level analysis 
> more.

(The underlying thread here being that the workqueue stuff _should_ be 
safe in this regard. But the "testing will not catch bugs like these is 
certainly true in general)

		Linus

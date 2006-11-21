Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031384AbWKUUSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031384AbWKUUSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031386AbWKUUSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:18:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49080 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1031383AbWKUUSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:18:50 -0500
Date: Tue, 21 Nov 2006 20:18:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [2.6.19 patch] i386/x86_64: remove the unused EXPORT_SYMBOL(dump_trace)
Message-ID: <20061121201844.GA7099@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <20061121194138.GF5200@stusta.de> <200611212047.30192.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611212047.30192.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 08:47:30PM +0100, Andi Kleen wrote:
> On Tuesday 21 November 2006 20:41, Adrian Bunk wrote:
> > This patch removes the unused EXPORT_SYMBOL(dump_trace) added on i386 
> > and x86_64 in 2.6.19-rc.
> > 
> > By removing them before the final 2.6.19 we avoid the possibility of 
> > people later whining that we removed exports they started using.
> 
> I exported it for systemtap so that they can stop using the broken
> hack they currently use as unwinder.

Nack, dump_trace is nothing that should be export for broken out of tree
junk.

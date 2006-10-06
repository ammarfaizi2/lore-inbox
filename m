Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbWJFUjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWJFUjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWJFUjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:39:21 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:40091 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932610AbWJFUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:39:20 -0400
Date: Fri, 6 Oct 2006 14:39:19 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Message-ID: <20061006203919.GS2563@parisc-linux.org>
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 10:33:19PM +0200, Jan Engelhardt wrote:
> 
> >+ *   the massive ternary operator construction
> >+	(sizeof(n) <= 4) ?			\
> >+	__ilog2_u32(n) :			\
> >+	__ilog2_u64(n)				\
> 
> Should not this be: sizeof(n) <= sizeof(u32)

Were you planning on porting Linux to a machine with non-8-bit-bytes any
time soon?  Because there's a lot more to fix than this.

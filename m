Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbUKCKjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbUKCKjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbUKCKjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:39:45 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:28423 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261510AbUKCKjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:39:44 -0500
Date: Wed, 3 Nov 2004 10:39:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 7/14] FRV: GDB stub dependent additional BUG()'s
Message-ID: <20041103103927.GA18416@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <20041102093440.GA5841@infradead.org> <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JULar023202@warthog.cambridge.redhat.com> <25541.1099411798@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25541.1099411798@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 04:09:58PM +0000, David Howells wrote:
> What's the best way to add an invoke_debugger() function without having to
> change every arch? #ifdef/#endif in kernel/panic.c maybe...

just put it in every arch.  Or even better drop your gdbstub for now
and integrate it with the common kgdb code in -mm.

Actually I think you should do thata anyway.

> Why? If you've got a debugger attached, it'd seem reasonable to want it to
> jump into the debugger in these circumstances; after all, your system is
> probably stuffed after this point.

Because it's not fatal without your debugger, so it shouldn't magically
get fatal.  If you think this is fatal convience Andrew to add a BUG() here.


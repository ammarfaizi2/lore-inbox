Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUAPOnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbUAPOmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:42:01 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:49156 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265177AbUAPOl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:41:56 -0500
Date: Fri, 16 Jan 2004 14:41:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: [PATCH 2.6] Altix updates
Message-ID: <20040116144132.A24555@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <200401152154.i0FLscIG023452@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200401152154.i0FLscIG023452@fsgi900.americas.sgi.com>; from pfg@sgi.com on Thu, Jan 15, 2004 at 03:54:37PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 03:54:37PM -0600, Pat Gefre wrote:
> 001-reorg.patch
> 002-reorg1.patch

The IS_IOADDR() stuff in the accesor funcs in pcibr_reg.c is completly
bogus, please decide whether you want to pass a pointer to the pcibr_soft
or bridge_t to it instead of doing second-guessing.

Also while the pic.h changes look okay they will conflict with a patch
I'm about to send that adds common headers for the bridge/xbow/xwidget
register for mips and IA64.  Can you send me a version of pic.h with
those changes and the big endian ifdefs back in so I can just incorporate
the new version into my patch?

Also are all those access you abstract away different in TIOCP?  If not
please don't add the wrappers for them.


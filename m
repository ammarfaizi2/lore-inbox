Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVFUUZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVFUUZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVFUUWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:22:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44457 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262315AbVFUUVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:21:54 -0400
Date: Tue, 21 Jun 2005 21:21:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Hans Reiser <reiser@namesys.com>, Alexander Zarochentcev <zam@namesys.com>,
       vs <vs@thebsh.namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050621202136.GA30182@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Hans Reiser <reiser@namesys.com>,
	Alexander Zarochentcev <zam@namesys.com>,
	vs <vs@thebsh.namesys.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621195642.GD14251@wotan.suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 09:56:43PM +0200, Andi Kleen wrote:
> On Tue, Jun 21, 2005 at 11:44:55AM -0700, Hans Reiser wrote:
> > vs and zam, please comment on what we get from our profiler and spinlock
> > debugger that the standard tools don't supply.  I am sure you have a
> > reason, but now is the time to articulate it.
> > 
> > We would like to keep the disabled code in there until we have a chance
> > to prove (or fail to prove) that cycle detection can be resolved
> > effectively, and then with a solution in hand argue its merits.
> 
> How about the review of your code base? Has reiser4 ever been
> fully reviewed by people outside your group? 

I don't think so.  Everyone used the previous criteria of the broken
core changes, broken filesystem semantics and it's own useless abtraction
layer (*) as an excuse not to look deeply at this huge mess yet.

(*) which isn't gone yet.  and I need to look again if the core changes
are okay yet.  And the broken sematics should go completely aswell, if
you want to reintroduce them it needs to happen at the VFS level anyway.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTJAJdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 05:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJAJdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 05:33:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:51590 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262056AbTJAJdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 05:33:51 -0400
Date: Wed, 1 Oct 2003 10:33:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001093329.GA2649@mail.shareable.org>
References: <20031001073132.GK1131@mail.shareable.org> <Pine.LNX.4.44.0310010900280.5501-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310010900280.5501-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 1 Oct 2003, Jamie Lokier wrote:
> > 
> > See recent message from me.  All you need is a check "address >=
> > TASK_SIZE", which is thread already at the start of do_page_fault.
> 
> What about the 4G+4G split?

Whoever is looking after the 4G+4G patch can deal with it, presumably.
It'll be the same condition ad 4G+4G uses to decide if it's an access
to userspace (needing a search of the vma list), or not.

-- Jamie

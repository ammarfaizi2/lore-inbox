Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbTJAItk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTJAItk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:49:40 -0400
Received: from ns.suse.de ([195.135.220.2]:3730 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262060AbTJAIt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:49:28 -0400
Date: Wed, 1 Oct 2003 10:49:26 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jamie Lokier <jamie@shareable.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001084926.GB22333@wotan.suse.de>
References: <20031001073132.GK1131@mail.shareable.org> <Pine.LNX.4.44.0310010900280.5501-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310010900280.5501-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 09:02:11AM +0100, Hugh Dickins wrote:
> On Wed, 1 Oct 2003, Jamie Lokier wrote:
> > 
> > See recent message from me.  All you need is a check "address >=
> > TASK_SIZE", which is thread already at the start of do_page_fault.
> 
> What about the 4G+4G split?

Whoever runs 4G+4G split surely doesn't care about fast paths because
of the large overhead it adds everywhere ;-)

They can check it always.

-Andi


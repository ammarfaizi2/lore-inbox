Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbUJZE0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUJZE0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUJZBiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:38:55 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47576 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262092AbUJZBXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:23:52 -0400
Date: Mon, 25 Oct 2004 18:33:35 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: javier@marcet.info, <linux-kernel@vger.kernel.org>, <kernel@kolivas.org>
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
In-Reply-To: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Rik van Riel wrote:
> On Mon, 25 Oct 2004, Andrew Morton wrote:
> > Rik van Riel <riel@redhat.com> wrote:
> > >
> > > -		if (referenced && page_mapping_inuse(page))
> > > +		if (referenced && sc->priority && page_mapping_inuse(page))
> > 
> > Makes heaps of sense, but I'd like to exactly understand why people are
> > getting oomings before doing something like this.  I think we're still
> > waiting for a testcase?
> 
> I'm now running Yum on a (virtual) system with 96MB RAM and
> 100MB swap.  This used to get an OOM kill very quickly, but
> still seems to be running now, after 20 minutes.

It completed, without being OOM killed like before.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


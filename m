Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269109AbUJEPlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269109AbUJEPlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269080AbUJEPgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:36:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269059AbUJEPfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:35:14 -0400
Date: Tue, 5 Oct 2004 11:35:07 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Jeff Moyer <jmoyer@redhat.com>
cc: linux-kernel@vger.kernel.org, <mingo@redhat.com>, <sct@redhat.com>
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
In-Reply-To: <16733.50382.569265.183099@segfault.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0410051134080.30172-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004, Jeff Moyer wrote:

> This patch makes an attempt at supporting the O_NONBLOCK flag for
> regular files.  It's pretty straight-forward.  One limitation is that we
> still call into the readahead code, which I believe can block.  
> However, if we don't do this, then an application which only uses
> non-blocking reads may never get it's data.

I like it, though for programs which are real serious about
O_NONBLOCK we might want to hand off readahead to a helper
thread instead of starting readahead in the same context...

Not sure if we would always want this, though ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


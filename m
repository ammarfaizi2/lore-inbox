Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbUCSQPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 11:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbUCSQPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 11:15:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20192 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263074AbUCSQPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 11:15:35 -0500
Date: Fri, 19 Mar 2004 11:15:30 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 5/6 anonmm
In-Reply-To: <Pine.LNX.4.44.0403182325280.16928-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403191113250.9221-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Hugh Dickins wrote:

> +	(*mapcount)--;

> +	if (anonmm->mm && anonmm->mm->rss) {
> +		referenced += page_referenced_one(
> +			page, anonmm->mm, page->index, mapcount);
> +		if (!*mapcount)
> +			goto out;
>  	}

Brilliant little optimisation over what I thought Linus
proposed at first.  This certainly removes the biggest
disadvantage I (and presumably Andrea) thought the mm
based reverse mapping would have !

I like this code a lot...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTJGMvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 08:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTJGMvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 08:51:46 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:29225 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262327AbTJGMvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 08:51:45 -0400
Date: Tue, 7 Oct 2003 08:51:23 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Jaroslav Kysela <perex@suse.cz>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, <andrea@suse.com>,
       <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] memory counting fix
In-Reply-To: <Pine.LNX.4.44.0310070844030.1494-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0310070850340.31052-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Marcelo Tosatti wrote:

> I dont see why reserved pages shouldnt be counted in the processes RSS.

Then you'll need to change about a dozen pieces of code
all over the place ;)

> What I'm missing here, Jaroslav?

The rest of the kernel doesn't count reserved pages as
part of the rss.  This patch seems to simply bring this
piece of code into line with the rest.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


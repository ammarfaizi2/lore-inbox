Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272655AbTG1EX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 00:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272650AbTG1EX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 00:23:29 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:50567 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S272648AbTG1EXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 00:23:25 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Carlos Velasco <carlosev@newipnet.com>, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Date: Sun, 27 Jul 2003 21:37:10 -0700 (PDT)
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
In-Reply-To: <20030727175557.1d624b36.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0307272133140.24695-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

can a summary of this discussion get written and put into the
documentation directory so that every time a new person stubles on this
feature we don't have to go through this discussion again?

David Lang

P.S. there are standards that are written documents and there are
standards that are 'how everyone does it' for the most part Linux follows
both types of standards, in this case the network team has decided to
ignore the 'how everyone else does it' standards becouse there is nothing
in a written standard that they are violating

 On Sun, 27 Jul
2003, David S. Miller wrote:

> Date: Sun, 27 Jul 2003 17:55:57 -0700
> From: David S. Miller <davem@redhat.com>
> To: Carlos Velasco <carlosev@newipnet.com>
> Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
>      linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
>      linux-kernel@vger.kernel.org
> Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
>
> On Mon, 28 Jul 2003 02:53:09 +0200
> "Carlos Velasco" <carlosev@newipnet.com> wrote:
>
> > But if the hidden patch and /proc switch would be in the main kernel,
> > it would be the simpliest way to solve all these "problems" (with an
> > echo "1" and without filtering or using iproute2).
>
> With or without your suggestion, people have to do something
> different.
>
> This doesn't even address all the problems there are with
> the hidden patch.  It does things that belong on the netfilter
> level and not on the ARP/routing level.
>
> Again, I'd like you to read all the discussions that have happened on
> this topic in the past, in particular those made by Alexey Kuznetsov
> on this topic.  He gives very clear and concise reasons why the
> "hidden" patch is logically doing things in the wrong part of the
> kernel, and therefore won't ever be put into the tree.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

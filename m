Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVCGQHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVCGQHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 11:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVCGQHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 11:07:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40899 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261811AbVCGQHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 11:07:01 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <E1D8KPt-00058Y-00@dorka.pomaz.szeredi.hu> 
References: <E1D8KPt-00058Y-00@dorka.pomaz.szeredi.hu>  <E1D8K3T-00056q-00@dorka.pomaz.szeredi.hu> <20050307041047.59c24dec.akpm@osdl.org> <20050307034747.4c6e7277.akpm@osdl.org> <20050307033734.5cc75183.akpm@osdl.org> <20050303123448.462c56cd.akpm@osdl.org> <20050302135146.2248c7e5.akpm@osdl.org> <20050302090734.5a9895a3.akpm@osdl.org> <9420.1109778627@redhat.com> <31789.1109799287@redhat.com> <13767.1109857095@redhat.com> <9268.1110194624@redhat.com> <9741.1110195784@redhat.com> <9947.1110196314@redhat.com> <22447.1110204304@redhat.com> <24382.1110210081@redhat.com> 
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, torvalds@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Mon, 07 Mar 2005 16:06:43 +0000
Message-ID: <24862.1110211603@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > It shouldn't silently break... It will refuse to compile. I renamed
> > "memory_backed" to "capabilities".
> 
> This will silently break:
> 
> static struct backing_dev_info my_bdi = {
>        .ra_pages = MY_RA,
>        .unplug_io_fn = default_unplug_io_fn,
> };

Sorry, yes. Obvious. Ugh. Andrew Morton suggested flipping the logic, and
although it was in conjunction with turning the concepts into bitfields, it
still stands here.

David

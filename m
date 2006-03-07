Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWCGNYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWCGNYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWCGNYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:24:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751220AbWCGNYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:24:32 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <440D76A4.8050703@yahoo.com.au> 
References: <440D76A4.8050703@yahoo.com.au>  <20060307113352.23330.80913.stgit@warthog.cambridge.redhat.com> <20060307113404.23330.71158.stgit@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Optimise d_find_alias() [try #6] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 07 Mar 2006 13:24:24 +0000
Message-ID: <25795.1141737864@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Having the smp_rmb() here implies there is some sort of memory barrier
> based synchronisation protocol at a higher level (than this function),
> because you don't actually do anything before them smp_rmb() here.
> 
> So can you comment what that is?

Hmmm... That probably shouldn't be there. I don't think Andrew Morton and I
actually came to an agreement as to whether it's necessary. I don't think it
is, he thought that it was, though he may have changed his mind.

David

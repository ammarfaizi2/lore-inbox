Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWHUJnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWHUJnO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWHUJnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:43:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7870 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751803AbWHUJnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:43:12 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0608202223220.29268@raven.themaw.net> 
References: <Pine.LNX.4.64.0608202223220.29268@raven.themaw.net>  <20060819094840.083026fd.akpm@osdl.org> <13319.1155744959@warthog.cambridge.redhat.com> <1155743399.5683.13.camel@localhost> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <5910.1155741329@warthog.cambridge.redhat.com> <2138.1155893924@warthog.cambridge.redhat.com> <3976.1156079732@warthog.cambridge.redhat.com> 
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 21 Aug 2006 10:42:53 +0100
Message-ID: <30856.1156153373@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> I guess I knew this would with the nfs v4 mounting.

And NFS2 and NFS3.  You just need a server that has two levels of export, one
under the other, for example:

	[/etc/exports]
	/               *(rw,async,fsid=0)
	/usr/src        *(rw,async,nohide)

David

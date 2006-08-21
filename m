Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWHULfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWHULfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWHULfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:35:36 -0400
Received: from mail.dotsterhost.com ([72.5.54.21]:50908 "HELO
	mail.dotsterhost.com") by vger.kernel.org with SMTP id S965066AbWHULfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:35:36 -0400
Date: Mon, 21 Aug 2006 19:35:24 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list
 [try #2]
In-Reply-To: <30856.1156153373@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0608211932300.27275@raven.themaw.net>
References: <Pine.LNX.4.64.0608202223220.29268@raven.themaw.net> 
 <20060819094840.083026fd.akpm@osdl.org> <13319.1155744959@warthog.cambridge.redhat.com>
 <1155743399.5683.13.camel@localhost> <20060813133935.b0c728ec.akpm@osdl.org>
 <20060813012454.f1d52189.akpm@osdl.org> <5910.1155741329@warthog.cambridge.redhat.com>
 <2138.1155893924@warthog.cambridge.redhat.com> <3976.1156079732@warthog.cambridge.redhat.com>
  <30856.1156153373@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006, David Howells wrote:

> Ian Kent <raven@themaw.net> wrote:
> 
> > I guess I knew this would with the nfs v4 mounting.
> 
> And NFS2 and NFS3.  You just need a server that has two levels of export, one
> under the other, for example:
> 
> 	[/etc/exports]
> 	/               *(rw,async,fsid=0)
> 	/usr/src        *(rw,async,nohide)

That makes it a bit hard as the /net functionality that Andrew is using is 
meant to mount all exports from the given server. In v4 that are mounted 
and umounted as a unit to deal with the nesting.

Ian


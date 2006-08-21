Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWHUMQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWHUMQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWHUMQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:16:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43727 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030405AbWHUMQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:16:31 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0608211932300.27275@raven.themaw.net> 
References: <Pine.LNX.4.64.0608211932300.27275@raven.themaw.net>  <Pine.LNX.4.64.0608202223220.29268@raven.themaw.net> <20060819094840.083026fd.akpm@osdl.org> <13319.1155744959@warthog.cambridge.redhat.com> <1155743399.5683.13.camel@localhost> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <5910.1155741329@warthog.cambridge.redhat.com> <2138.1155893924@warthog.cambridge.redhat.com> <3976.1156079732@warthog.cambridge.redhat.com> <30856.1156153373@warthog.cambridge.redhat.com> 
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 21 Aug 2006 13:16:07 +0100
Message-ID: <323.1156162567@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> That makes it a bit hard as the /net functionality that Andrew is using is 
> meant to mount all exports from the given server.

But does it _matter_ that the thing is mounted or dismounted as a unit?  And
if so, why?

> In v4 that are mounted and umounted as a unit to deal with the nesting.

Why does the automounter daemon have to do the mounting of submounts?  What's
wrong with having the kernel do it?  The one problem with having the kernel do
it that I can see, is that the kernel doesn't update /etc/mtab.


Note that rather than manually mounting the submounts, you could just open and
close those directories as that should cause them to automount - though the
xdev mountpoints will expire and become automatically unmounted after a
certain period.

David

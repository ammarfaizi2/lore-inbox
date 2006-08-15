Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965341AbWHOJwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965341AbWHOJwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965342AbWHOJwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:52:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37558 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965341AbWHOJwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:52:21 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060814143110.f62bfb01.akpm@osdl.org> 
References: <20060814143110.f62bfb01.akpm@osdl.org>  <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <10791.1155580339@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 10:51:53 +0100
Message-ID: <918.1155635513@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> bix:/home/akpm> cat /etc/exports
> /               *(rw,async)
> /usr/src        *(rw,async)
> /mnt/export     *(rw,async)

Hmmm... I still can't reproduce it.

What happens if you change your /etc/exports file to:

/               *(rw,async,fsid=0)
/usr/src        *(rw,async,nohide)
/mnt/export     *(rw,async,nohide)

Also, does removing the "/mnt/export" line from /etc/exports mean that the
/mnt reappears in the directory listing?

David

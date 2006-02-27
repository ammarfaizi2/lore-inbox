Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWB0W4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWB0W4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWB0W4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:56:34 -0500
Received: from gardeny.udl.es ([193.144.12.130]:18081 "EHLO relay3.udl.es")
	by vger.kernel.org with ESMTP id S932358AbWB0W4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:56:33 -0500
Subject: Re: kernel BUG at fs/locks.c:1932!
From: Fermin Molina <fermin@asic.udl.es>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1140373675.7883.45.camel@lade.trondhjem.org>
References: <1140189359.22719.51.camel@viagra.udl.net>
	 <1140373675.7883.45.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 27 Feb 2006 23:56:07 +0100
Message-Id: <1141080967.13730.27.camel@fucker.pikadero.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 13:27 -0500, Trond Myklebust wrote:
> On Fri, 2006-02-17 at 16:15 +0100, Fermin Molina wrote:
> > Hi,
> > 
> > I run samba sharing NFS mounted shares from another machine. I'm getting
> > the following bugs in console (and in logs), when I stop samba (but not
> > always, I think it depends of stalled locks):
> > 
> > lockd: unexpected unlock status: 7
> > lockd: unexpected unlock status: 7
> > lockd: unexpected unlock status: 7
> > ------------[ cut here ]------------
> 
> Hmm... The problem here is that the server is returning an unexpected
> error: it is normally supposed to return "lock granted" or "grace
> error", but is actually returning "stale filehandle".
> 
> Anyhow, the client should be able to deal with this without Oopsing.
> 
> The attached patch ought to fix that. Please could you give it a try?


Sorry for the delay. I cannot try the patch in this moment, because my
server is in production. I will try the patch next days, but I think I
cannot reproduce the error, because I made "local" some data mounted
with NFS.

In samba list, some people that have data mounted with NFS are getting
similar problems. I will let they know about this patch.

Thanks a lot,

-- 
Fermin Molina Ibarz
Tècnic sistemes - ASIC
Universitat de Lleida
Tel: +34 973 702151
GPG: 0x060F857A



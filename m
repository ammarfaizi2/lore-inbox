Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUDLPYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 11:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUDLPYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 11:24:45 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:54147
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S261779AbUDLPYo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 11:24:44 -0400
Subject: Re: NFS umount
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1081781374.5620.4.camel@bluerhyme.real3>
References: <1081781374.5620.4.camel@bluerhyme.real3>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1081783482.2617.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Apr 2004 08:24:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På m , 12/04/2004 klokka 07:49, skreiv Fabian Frederick:
> Hi,
> 
> 	I was looking at NFS source code and I can't find where the umount
> takes place in server side.... It seems nfsd/export.c has some functions
> for that, but I added debugging there and nothing happens when umounting
> from client/side.Someone could help me ? I read about some rpc.umountd
> but was unable to find it on my system ...

There is no such thing as rpc.umountd.

There is a "umount" RPC call that is used to notify rpc.mountd that
we're unmounting the filesystem (see RFC1094 and RFC1813), but that is
only used in order to manage an internal cache of clients. It doesn't do
anything beyond that.

Cheers,
  Trond

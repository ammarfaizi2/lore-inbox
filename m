Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVLPXxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVLPXxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbVLPXtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:49:40 -0500
Received: from pat.uio.no ([129.240.130.16]:44214 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964832AbVLPXtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:49:24 -0500
Subject: Re: lockd: couldn't create RPC handle for (host)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20051216205536.GA20497@tau.solarneutrino.net>
References: <20051216205536.GA20497@tau.solarneutrino.net>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 18:49:05 -0500
Message-Id: <1134776945.7952.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.022, required 12,
	autolearn=disabled, AWL 1.79, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 15:55 -0500, Ryan Richter wrote:
> Hi, nfs locking stopped working on my file server running 2.6.15-rc5
> today.  All clients that try locking operations hang, and I get the
> message from the server:
> 
> lockd: couldn't create RPC handle for w.x.y.z

Points either to a client which is not responding to callbacks, or an
OOM situation on the server.

Does 'rpcinfo -u w.x.y.z 100021' work from the server?

> Also, the lockd process is unkillable, it looks like I'll have to
> reboot.

lockd cannot be killed as long as you have active nfsd threads or active
nfs client partitions. That is by design.

Cheers,
  Trond


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264084AbUD0NiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbUD0NiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 09:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUD0NiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 09:38:11 -0400
Received: from ns.suse.de ([195.135.220.2]:53680 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264084AbUD0NiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 09:38:08 -0400
Subject: Re: [PATCH 1/11] sunrpc-enosys-when-unavail
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1083011614.15282.19.camel@lade.trondhjem.org>
References: <1082975161.3295.70.camel@winden.suse.de>
	 <1083011614.15282.19.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1083073087.19655.9.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 27 Apr 2004 15:38:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

net/sunrpc/svc.c has a similar check already to prevent syslog flooding
for such common error conditions:

[] #ifdef RPC_PARANOIA
[]         if (prog != 100227 || progp->pg_prog != 100003)
[]                 printk("svc: unknown program %d (me %d)\n", prog, progp->pg_prog);
[]         /* else it is just a Solaris client seeing if ACLs are supported */
[] #endif

We could also get rid of the printk's in net/sunrpc/clnt.c -- your/Neil's call.

On Mon, 2004-04-26 at 22:33, Trond Myklebust wrote:
> On Mon, 2004-04-26 at 06:28, Andreas Gruenbacher wrote:
> > Differentiate between program/procedure not available and other errors
> > 
> 
> Sorry. This one is unacceptable. I will NOT have program numbers hard
> coded into sunrpc. There should be no reason to do this at all...
> 
> Cheers,
>   Trond
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG


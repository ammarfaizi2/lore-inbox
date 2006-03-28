Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWC1Pxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWC1Pxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWC1Pxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:53:48 -0500
Received: from pat.uio.no ([129.240.10.6]:39338 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932070AbWC1Pxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:53:47 -0500
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Edward Chernenko <edwardspec@yahoo.com>
Cc: linux-kernel@vger.kernel.org, edwardspec@gmail.com
In-Reply-To: <20060328154841.74612.qmail@web37708.mail.mud.yahoo.com>
References: <20060328154841.74612.qmail@web37708.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 10:53:27 -0500
Message-Id: <1143561207.8009.58.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.073, required 12,
	autolearn=disabled, AWL 1.74, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 07:48 -0800, Edward Chernenko wrote:
> 
> --- Trond Myklebust <trond.myklebust@fys.uio.no>
> wrote:
> 
> > Most servers are designed for low latency. A lot of
> > them sleep a lot,
> > and a fair number of them also go poking around the
> > kernel variables
> > in /proc (which exists precisely in order to export
> > internal kernel
> > variables to userspace programs). I'll bet even your
> > average Oracle
> > database application fits those criteria.
> > 
> > Echo made sense to move into the kernel because in
> > addition to the above
> > it is a required feature on all Internet hosts, is
> > pretty much stateless
> > (and/or depends only on internal IP stack state),
> > and needs extra low
> > latency because it is designed to be used for timing
> > purposes by
> > clients.
> > The same criteria hardly apply to identd.
> 
> If so, then why khttpd _was_ included into kernel?

That has been widely acknowledged as a mistake. You'll note that khttpd
was removed prior to the release of linux-2.6.0. Nobody misses it.

Cheers,
  Trond


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbWASDZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbWASDZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWASDZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:25:01 -0500
Received: from pat.uio.no ([129.240.130.16]:40651 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030483AbWASDZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:25:00 -0500
Subject: Re: Can you specify a local IP or Interface to be used on a
	per	NFS mount basis?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43CEF7A6.30802@candelatech.com>
References: <43CECB00.40405@candelatech.com>
	 <1137631728.13076.1.camel@lade.trondhjem.org>
	 <43CEF7A6.30802@candelatech.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 22:24:44 -0500
Message-Id: <1137641084.8864.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.045, required 12,
	autolearn=disabled, AWL 1.77, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 18:21 -0800, Ben Greear wrote:

> > NFS doesn't know anything about ip packet routing. That is a networking
> > issue.
> 
> When a socket is created, you can optionally bind to local IP, interface and/or
> IP-Port.  Somewhere, NFS is opening a socket I assume?  So, is there a way to
> ask it to bind?


As David said, the place to fix it is in xs_bindresvport(), but there is
no support for passing this sort of information through the current NFS
binary mount structure. You would have to hack that up yourself.

Cheers,
  Trond


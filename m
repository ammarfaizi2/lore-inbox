Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVCVAZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVCVAZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVCVAXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:23:04 -0500
Received: from pat.uio.no ([129.240.130.16]:30688 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262216AbVCVAWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:22:34 -0500
Subject: Re: Make NFS userspace and server directories cookies independant
	[patch, fc3, 2.6.10-1.766_FC3]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
In-Reply-To: <20050322000210.GA4681@dspnet.fr.eu.org>
References: <20050321162142.GB46055@dspnet.fr.eu.org>
	 <1111427218.10508.27.camel@lade.trondhjem.org>
	 <20050322000210.GA4681@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 19:22:16 -0500
Message-Id: <1111450936.10980.55.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.703, required 12,
	autolearn=disabled, AWL 1.30, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 22.03.2005 Klokka 01:02 (+0100) skreiv Olivier Galibert:
> On Mon, Mar 21, 2005 at 12:46:58PM -0500, Trond Myklebust wrote:

> +	if (filp->f_pos == ctx->dir_pos)
> +		desc->target_cookie = ctx->dir_cookie;
> +	else
> +		desc->target_cookie = 0;

This sort of thing worries me: I think we can do better by hooking
lseek() on directories. I'll see what I can do.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


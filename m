Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVKKTZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVKKTZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVKKTZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:25:40 -0500
Received: from pat.uio.no ([129.240.130.16]:64450 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751093AbVKKTZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:25:39 -0500
Subject: Re: local denial-of-service with file leases
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chris Wright <chrisw@osdl.org>
Cc: Avi Kivity <avi@argo.co.il>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051111183512.GV5856@shell0.pdx.osdl.net>
References: <43737CBE.2030005@argo.co.il>
	 <20051111084554.GZ7991@shell0.pdx.osdl.net>
	 <1131718887.8805.33.camel@lade.trondhjem.org>
	 <20051111183512.GV5856@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 14:25:27 -0500
Message-Id: <1131737127.8793.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.87, required 12,
	autolearn=disabled, AWL 1.13, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 10:35 -0800, Chris Wright wrote:
> * Trond Myklebust (trond.myklebust@fys.uio.no) wrote:
> > Bruce has a simpler patch (see attachment). The call to fasync_helper()
> > in order to free active structures will have already been done in
> > locks_delete_lock(), so in principle, all we want to do is to skip the
> > fasync_helper() call in fcntl_setlease().
> 
> Yes, that's better, thanks.  Will you make sure it gets to Linus?

Sure, but I'd like a mail from Avi confirming that this patch too fixes
his problem, please.

Cheers,
  Trond


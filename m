Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVF1UPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVF1UPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVF1UPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:15:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47297 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261250AbVF1ULR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:11:17 -0400
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87vf3y2qzz.fsf@jbms.ath.cx>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net>
	 <87oe9q70no.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281218030.1454@graphe.net>
	 <87hdfi704d.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281230550.1630@graphe.net>
	 <20050628194215.GB32240@infradead.org>  <87vf3y2qzz.fsf@jbms.ath.cx>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 22:11:02 +0200
Message-Id: <1119989463.3175.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 15:52 -0400, Jeremy Maitin-Shepard wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Tue, Jun 28, 2005 at 12:31:33PM -0700, Christoph Lameter wrote:
> >> On Tue, 28 Jun 2005, Jeremy Maitin-Shepard wrote:
> >> 
> >> > It would probably be better implemented with a more generic mechanism,
> >> > but I don't believe anyone is working on that now, so it looks like AFS
> >> > will continue to use a special syscall.
> >> 
> >> We could put an #ifdef CONFIG_AFS into the syscall table definition?
> >> That makes it explicit.
> 
> > No.  AFS is utterly wrong, and the sooner we make it fail to work the
> > better.
> 
> Heh, well that is nice, but breaking it will only mean that I and every
> other AFS user will have to revert the patch that breaks it;
> furthermore, many distributions that provide binary kernels will
> probably also have to revert the patch because many of their users will
> want to use AFS.

AFS isn't even using it... after all it's not even exported.



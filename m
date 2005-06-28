Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVF1Tum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVF1Tum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVF1TuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:50:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63424 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261232AbVF1Try (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:47:54 -0400
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87hdfi704d.fsf@jbms.ath.cx>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net>
	 <87oe9q70no.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281218030.1454@graphe.net>
	 <87hdfi704d.fsf@jbms.ath.cx>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 21:47:48 +0200
Message-Id: <1119988068.3175.47.camel@laptopd505.fenrus.org>
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

On Tue, 2005-06-28 at 15:27 -0400, Jeremy Maitin-Shepard wrote:
> Christoph Lameter <christoph@lameter.com> writes:
> 
> > On Tue, 28 Jun 2005, Jeremy Maitin-Shepard wrote:
> >> As I mentioned previously when this patch was first posted to the list,
> >> AFS writes to the syscall table.  It does this even for Linux 2.6.
> >> Apparently, the rodata section is not actually mapped read-only, so this
> >> patch will probably not break AFS; nonetheless, it seems it would still
> >> be better to keep the syscall table in a section that is supposed to be
> >> writable.
> 
> > Maybe this needs to be fixed?
> 
> It would probably be better implemented with a more generic mechanism,
> but I don't believe anyone is working on that now, so it looks like AFS
> will continue to use a special syscall.

the kernel afs doesnt' seem to need a special syscall....




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVBSJL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVBSJL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVBSJKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:10:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60594 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261726AbVBSJJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 04:09:10 -0500
Subject: Re: [2.6 patch] drivers/net/smc-mca.c: cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4216FBCB.8040807@pobox.com>
References: <20050219083431.GN4337@stusta.de>  <4216FBCB.8040807@pobox.com>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 10:09:00 +0100
Message-Id: <1108804140.6304.67.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
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

On Sat, 2005-02-19 at 03:41 -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> > This patch contains the following cleanups:
> > - make a needlessly global function static
> > - make three needlessly global structs static
> > 
> > Since after moving the now-static stucts to smc-mca.c the file smc-mca.h 
> > was empty except for two #define's, I've also killed the rest of 
> > smc-mca.h .
> 
> It looks like the structs should be 'static const', not just 'static'.
> 
> This comment is applicable to similar changes, also.  Use 'const' 
> whenever possible.

does that even have meaning in C? In C++ it does, but afaik in C it
doesn't.



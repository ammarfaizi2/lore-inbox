Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVDJTs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVDJTs7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVDJTs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 15:48:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58505 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261590AbVDJTs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 15:48:57 -0400
Subject: Re: [PATCH] re-export cancel_rearming_delayed_workqueue
From: Arjan van de Ven <arjan@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1113160044.6737.12.camel@mulgrave>
References: <1113160044.6737.12.camel@mulgrave>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 21:48:50 +0200
Message-Id: <1113162531.15213.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
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

On Sun, 2005-04-10 at 14:07 -0500, James Bottomley wrote:
> This was unexported by Arjan because we have no current users.
> 
> However, during a conversion from tasklets to workqueues of the parisc
> led functions, we ran across a case where this was needed.  In
> particular, the open coded equivalent of
> cancel_rearming_delayed_workqueue was implemented incorrectly, which is,
> I think, all the evidence necessary that this is a useful API.

I have absolutely no problem with such an export / unstatic if there are
users... could you just send them in one go ?



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVCOHQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVCOHQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 02:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVCOHQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 02:16:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64430 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262316AbVCOHQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 02:16:32 -0500
Subject: Re: [PATCH] reduce __deprecated spew
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050314224221.442570a8.akpm@osdl.org>
References: <20050315063436.GN32638@waste.org>
	 <20050314224221.442570a8.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 08:16:24 +0100
Message-Id: <1110870984.6290.32.camel@laptopd505.fenrus.org>
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


> (The intermodule_register and pm_register stuff has been hanging around for
> so long that one wonders if we need sterner stimuli, not lesser).

intermodule can just about go (one user left).. we could start by making
the intermodule.c file only build when that one user is selected (that
user is a corner case) to avoid others from accidentally starting to use
it again ...


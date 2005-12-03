Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVLCOgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVLCOgp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 09:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVLCOgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 09:36:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51621 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750893AbVLCOgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 09:36:44 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051203135608.GJ31395@stusta.de>
References: <20051203135608.GJ31395@stusta.de>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 15:36:38 +0100
Message-Id: <1133620598.22170.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ase for a stable series.
> 
> After 2.6.16, there will be a 2.6.16.y series with the usual stable 
> rules.
> 
> After the release of 2.6.17, this 2.6.16.y series will be continued with 
> more relaxed rules similar to the rules in kernel 2.4 since the release 
> of kernel 2.6.0 (e.g. driver updates will be allowed).
> 


this is a contradiction. You can't eat a cake and have it; either you're
really low churn (like existing -stable) or you start adding new
features like hardware support. the problem with hardware support is
that it's not just a tiny driver update. If involves midlayer updates as
well usually, and especially if those midlayers diverge between your
stable and mainline, the "backports" are getting increasingly unsafe and
hard.

If the current model doesn't work as you claim it doesn't, then maybe
the model needs finetuning. Right now the biggest pain is the userland
ABI changes that need new packages; sometimes (often) for no real hard
reason. Maybe we should just stop doing those bits, they're not in any
fundamental way blocking general progress (sure there's some code bloat
due to it, but I guess we'll just have to live with that).




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVCZLqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVCZLqd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 06:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVCZLqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 06:46:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52646 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262048AbVCZLqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 06:46:24 -0500
Subject: Re: Linux 2.4.30-rc2
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, davej@redhat.com
In-Reply-To: <20050326113426.GO30052@alpha.home.local>
References: <20050326004631.GC17637@logos.cnet>
	 <20050326113426.GO30052@alpha.home.local>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 12:46:19 +0100
Message-Id: <1111837579.8042.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.4 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.7 RISK_FREE              BODY: Risk free.  Suuurreeee....
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

On Sat, 2005-03-26 at 12:34 +0100, Willy Tarreau wrote:
> Marcelo,
> 
> just another one and that's all. Zachary Amsden found an unconditional
> write to a debug register in the signal delivery path which is only
> needed when we use a breakpoint. This is a very expensive operation on
> x86, and doing it conditionnaly enhanced signal delivery speed by 33%
> for him.

this sounds rather risky for this late in the game; heck it sounds risky
in 2.4 period. This code changed a lot in 2.6 so just a plain backport
is by no means risk free, while the effect of a wrong debug register can
even have security impact. 


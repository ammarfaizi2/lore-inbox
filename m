Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVAQLUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVAQLUW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 06:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVAQLUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 06:20:22 -0500
Received: from canuck.infradead.org ([205.233.218.70]:38670 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261266AbVAQLUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 06:20:17 -0500
Subject: Re: [2.6 patch] x8664_ksyms.c: unexport register_die_notifier
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050117101318.GF29270@wotan.suse.de>
References: <20050116074649.GW4274@stusta.de>
	 <20050117092654.GB29270@wotan.suse.de>
	 <1105955659.6304.62.camel@laptopd505.fenrus.org>
	 <20050117101318.GF29270@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 12:19:28 +0100
Message-Id: <1105960768.6304.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 11:13 +0100, Andi Kleen wrote:
> On Mon, Jan 17, 2005 at 10:54:18AM +0100, Arjan van de Ven wrote:
> > On Mon, 2005-01-17 at 10:26 +0100, Andi Kleen wrote:
> > > On Sun, Jan 16, 2005 at 08:46:49AM +0100, Adrian Bunk wrote:
> > > > The only user of register_die_notifier (kernel/kprobes.c) can't be 
> > > > built modular. Therefore, it's the EXPORT_SYMBOL is superfluous.
> > > 
> > > Please don't apply this, it was especially intended for modular debuggers.
> > > There is already a hacvked kdb around that uses it.
> > 
> > eh didn't Tigran just mail lkml claiming that kdb and x86-64 really
> > don't mix ??
> 
> It cannot display function arguments and uses imprecise backtrace right now
> (like normal oopses), other than that it works just fine. 

does it need any other kernel patches? Because if it does it might as
well patch this export in for it's specialist use


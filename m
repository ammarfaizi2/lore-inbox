Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVLPUJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVLPUJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 15:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVLPUJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 15:09:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18389 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750807AbVLPUJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 15:09:02 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Buesch <mbuesch@freenet.de>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, Adrian Bunk <bunk@stusta.de>,
       akpm@osdl.org, Diego Calleja <diegocg@gmail.com>
In-Reply-To: <1134763370.28761.61.camel@localhost.localdomain>
References: <20051215212447.GR23349@stusta.de>
	 <20051216163503.289d491e.diegocg@gmail.com>
	 <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
	 <200512161723.19965.mbuesch@freenet.de>
	 <1134763370.28761.61.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 21:08:57 +0100
Message-Id: <1134763738.2992.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 20:02 +0000, Alan Cox wrote:
> On Gwe, 2005-12-16 at 17:23 +0100, Michael Buesch wrote:
> > Now, I want to test bcm43xx on 4k stacks. But only have a
> > ppc32 machine with such a broadcom card. ppc32 has 8k stacks.
> > How am I supposed to test the driver for 4kstack conformance?
> 
> Unless you've been writing fairly careless code putting a lot of objects
> on stack a driver is going to work fine with 4K stacks.

there is also "make checkstack" that works on many architectures, and
lists offenders. If you're clean there it's very likely you're very
ok ;)


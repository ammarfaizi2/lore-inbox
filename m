Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTK1JmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 04:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTK1JmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 04:42:25 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:47280 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262092AbTK1JmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 04:42:23 -0500
Subject: Re: [PATCH 2.6]: IPv4: strcpy -> strlcpy
From: David Woodhouse <dwmw2@infradead.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Timo Kamph <timo@kamph.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, davem@redhat.com
In-Reply-To: <1069970946.2138.13.camel@teapot.felipe-alfaro.com>
References: <20031127142125.GG8276@jdj5.mit.edu>
	 <3FC67128.14704.30155D53@localhost>
	 <1069970946.2138.13.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1070012538.10048.13.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.1) 
Date: Fri, 28 Nov 2003 09:42:18 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-27 at 23:09 +0100, Felipe Alfaro Solana wrote:
> On Thu, 2003-11-27 at 21:48, Timo Kamph wrote:
> 
> > > +	strlcpy(label->label, name, sizeof(label->name));
> >                                                                        ^^^^^^
> > I guess this shoud be label->label, or am I wrong?
> 
> Oh my god! Two consecutive mistakes with the same patch! I should have
> some sleep... Here's the one with the typo corrected.

Perhaps we should consider

#define strsizecpy(x, y) strlcpy((x), (y), sizeof(x))

-- 
dwmw2


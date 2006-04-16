Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWDPTKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWDPTKm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 15:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWDPTKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 15:10:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23007 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750796AbWDPTKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 15:10:41 -0400
Subject: Re: [RFC: 2.6 patch] net/irda/irias_object.c: remove unused exports
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jt@hpl.hp.com, Adrian Bunk <bunk@stusta.de>, Samuel.Ortiz@nokia.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1145212639.5656.3.camel@localhost.localdomain>
References: <20060414114446.GL4162@stusta.de>
	 <20060414164203.GA24146@bougret.hpl.hp.com>
	 <1145209616.3809.14.camel@laptopd505.fenrus.org>
	 <1145212639.5656.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 16 Apr 2006 21:07:26 +0200
Message-Id: <1145214446.3809.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-16 at 19:37 +0100, Alan Cox wrote:
> On Sul, 2006-04-16 at 19:46 +0200, Arjan van de Ven wrote:
> > > 	Personally, I don't see what this patch buy us...
> > 
> > all the unused exports in the kernel together make a binary kernel 100Kb
> > bigger. It's a case of a lot of little steps I suppose (each export
> > taking like 100 to 150 bytes depending on the size of the function name)
> 
> 
> So why are exports taking us 100-150 bytes, not say 20 which is what I'd
> expect ?

there is the name, the crc, the address, a module name thingy (which I
think is only filled for non-built-in symbols) and I'm sure there's some
padding here and there... 

About 1/3rd of all exports is unused, so killing those is an easy way to
gain back the space...





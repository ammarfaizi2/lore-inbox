Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269076AbUIRAMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269076AbUIRAMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 20:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269070AbUIRAMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 20:12:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:60847 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269078AbUIRAMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 20:12:34 -0400
Subject: Re: [BUG] ub.c badness in current bk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040917090448.32ff763c@lembas.zaitcev.lan>
References: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
	 <20040917002935.77620d1d@lembas.zaitcev.lan>
	 <1095414394.13531.77.camel@gaston>
	 <20040917090448.32ff763c@lembas.zaitcev.lan>
Content-Type: text/plain
Message-Id: <1095466334.3660.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 18 Sep 2004 10:12:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-18 at 02:04, Pete Zaitcev wrote:
> On Fri, 17 Sep 2004 19:46:34 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Ok, here's a modified patch that fixes the problem for me.
> 
> > +	ret = sc->changed;
> > +	/* P3 */ printk("%s: %s changed\n", sc->name, ret ? "is": "was not");
> > +	
> > +	sc->changed = 0;
> >  	return sc->changed;
> >  }
> 
> You return zero always. I don't think it's supposed to be that way.
> I'm sorry, but I cannot apply it. I'll look for a better solution.

Oh, and I confirm that just returning "ret" here (that is practically
making sure we only ever return 1 once in my test) still triggers the
problem... weird weird

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269056AbUIRAIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269056AbUIRAIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 20:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269070AbUIRAIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 20:08:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:59055 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269056AbUIRAIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 20:08:35 -0400
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
Message-Id: <1095466107.3669.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 18 Sep 2004 10:08:27 +1000
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

Oops, my wrong, it indeed doesn't make sense... Well, the problem is definitely
around here anyway... I'll do more tests when I'm more awake this week-end, the
above was done while I was fairly tired ;)

Ben.
 


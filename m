Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWD0UCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWD0UCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWD0UCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:02:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20193 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030204AbWD0UCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:02:11 -0400
Subject: Re: CONFIG_KMOD in x86_64/defconfig (was Re: iptables is
	complaining with bogus unknown error 18446744073709551615)
From: Arjan van de Ven <arjan@infradead.org>
To: Harald Welte <laforge@netfilter.org>
Cc: Maurice Volaski <mvolaski@aecom.yu.edu>, netfilter@lists.netfilter.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060427192430.GE21823@rama>
References: <200604210738.k3L7cBGO010103@mailgw.aecom.yu.edu>
	 <a06230901c075ca078b8d@[129.98.90.227]> <20060427135119.GB5177@rama>
	 <a06230904c07687df0a33@[129.98.90.227]>  <20060427192430.GE21823@rama>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 22:01:57 +0200
Message-Id: <1146168118.2894.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 16:24 -0300, Harald Welte wrote:
> On Thu, Apr 27, 2006 at 11:41:40AM -0400, Maurice Volaski wrote:
> > >On Wed, Apr 26, 2006 at 09:12:38PM -0400, Maurice Volaski wrote:
> > >> Automatic kernel module loading! That is an option and it's off by
> > >> default. When it's off, attempts to load kernel modules are ignored
> > >> internally, and that's why iptables was failing. It tried to load
> > >> xt_tcpudp, but was ignored by the kernel.
> > >What do you mean by "it's an option" and "is off by default".  I would
> > >claim that any major linux distribution that I've seen in the last ten
> > >years has support for module auto loading (enabled by default).
> > 
> > Distribution vendors are free to change it to whatever they want, I guess, but it's OFF by 
> > default in the official kernel (.config).
> 
> apparently architecture-specific:
> 
> grep KMOD arch/i386/defconfig
> CONFIG_KMOD=y
> 
> grep KMOD arch/x86_64/defconfig
> CONFIG_KMOD is not set
> 
> don't know why x86_64 turns it off by default.  the help message says
> 'if unsure, say Y' (which makes sense!)


also defconfig is really irrelevant... you should look at what the
Kconfig has to say


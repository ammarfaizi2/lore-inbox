Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTEMPO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbTEMPO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:14:57 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:56325 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S261352AbTEMPO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:14:56 -0400
Date: Tue, 13 May 2003 17:27:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Miles Bader <miles@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
In-Reply-To: <buou1bz7h9a.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0305131710280.5042-100000@serv>
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
 <buou1bz7h9a.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13 May 2003, Miles Bader wrote:

> > I have the following two entries in my Kconfig file (arch/v850/Kconfig):
> >
> >    config RTE_CB_MULTI
> >    	  bool
> > 	  # RTE_CB_NB85E can either have multi ROM support or not, but
> > 	  # other platforms (currently only RTE_CB_MA1) require it.
> > 	  prompt "Multi monitor ROM support" if RTE_CB_NB85E
> > 	  depends RTE_CB
> > 	  default y
> >
> >    config RTE_CB_MULTI_DBTRAP
> >    	  bool "Pass illegal insn trap / dbtrap to kernel"
> > 	  depends RTE_CB_MULTI
> > 	  default n
> >
> > What I expect this to do is to only ask the first question (RTE_CB_MULTI)
> > if RTE_CB_NB85E is true and otherwise just assume true -- this part
> > seems to work correctly -- but to _always_ ask the second question
> > (RTE_CB_MULTI_DBTRAP) as long as its dependencies are true.

With the new patch this will work. The effect is basically the same as if 
you would add "enable RTE_CB_MULTI" to RTE_CB_MA1 - RTE_CB_MULTI is 
visible but you cannot change it.
BTW you can remove the "default n" line, this is the default anyway, so 
it has no effect.

bye, Roman


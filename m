Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265592AbUFDEeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbUFDEeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 00:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbUFDEeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 00:34:25 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:60321 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265592AbUFDEdp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 00:33:45 -0400
Subject: Re: idebus setup problem (2.6.7-rc1)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Herbert Poetzl <herbert@13thfloor.at>, "Zhu, Yi" <yi.zhu@intel.com>,
       Auzanneau Gregory <mls@reolight.net>, Jeff Garzik <jgarzik@pobox.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200406032344.19152.bzolnier@elka.pw.edu.pl>
References: <3ACA40606221794F80A5670F0AF15F8403BD54FE@PDSMSX403.ccr.corp.intel.com>
	 <20040603213115.GA1107@MAIL.13thfloor.at>
	 <200406032344.19152.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1086323563.29391.1039.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 14:32:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-04 at 07:44, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 03 of June 2004 23:31, Herbert Poetzl wrote:
> > On Thu, Jun 03, 2004 at 10:05:08PM +0800, Zhu, Yi wrote:
> > > Rusty Russell wrote:
> > > > Dislike this idea.  If you have hundreds of parameters, maybe it's
> > > > supposed to be a PITA?
> > >
> > > What's your idea to make module_param support alterable param
> > > names like ide3=xxx ?
> >
> > hmm, what about making all those something like:
> >
> > 	ide=3:foo,bar;4:wossname
> 
> We are in stable kernel and in 2.7 'idex=' and 'hdx=' will die.

Yes, and if you want to clean this up for 2.6, I'd recommend simply
putting twenty module_param_call() lines.

It's ugly, but that's because it's doing ugly things, IMHO, and I don't
think Bart would disagree?

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266583AbUBDWYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266651AbUBDWYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:24:41 -0500
Received: from smtp1.pp.htv.fi ([212.90.64.119]:27618 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S266583AbUBDWWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:22:50 -0500
Subject: Re: NGROUPS 2.6.2rc2
From: Panu Matilainen <pmatilai@welho.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Tim Hockin <thockin@sun.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
In-Reply-To: <20040203221719.GA465@elf.ucw.cz>
References: <Pine.LNX.4.44.0401281757190.6213-100000@localhost.localdomain>
	 <Pine.LNX.4.58.0401281007420.27790@home.osdl.org>
	 <20040128222225.GH9155@sun.com>  <20040203221719.GA465@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1075932274.8336.10.camel@chip.laiskiainen.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 05 Feb 2004 00:11:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 00:17, Pavel Machek wrote:
> Hi!
> 
> > > Although I do believe that it would be better written as
> > > 
> > > 	#define MAXGROUPS (1000) /* Arbitrary, but we have to limit it somehere */
> > > 
> > > 	if ((unsigned) info->ngroups > MAXGROUPS)
> > > 		return -ETOOEFFINGLARGE;
> > > 
> > > as I absolutely _despise_ code that tries to be too generic. 
> > > 
> > > What is it with CS classes that have removed "common sense" from the 
> > > equation?
> > 
> > OK, there are two easy answers to this.  I can re-work it with a simple 32k
> > limit that needs to be recompiled to change, or I can add a sysctl to
> > control it (it appeared in an early version of this patch).
> 
> I guess static limit is okay for this...

Maybe static limit is enough but it's more than just a bit annoying when
you hit that <limit>+1 mark. Oh well, just upping the current limit *a
lot* would make life easier for some of us.

	- Panu -



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWAFMUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWAFMUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWAFMUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:20:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46278 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750771AbWAFMUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:20:22 -0500
Subject: Re: [PATCH] Remove gfp argument from kstrdup()
From: Arjan van de Ven <arjan@infradead.org>
To: Timo Hirvonen <tihirvon@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060106141509.01c66bf2.tihirvon@gmail.com>
References: <20060105234253.758b126a.tihirvon@gmail.com>
	 <84144f020601060351g48f3ef5bqf25a2a1bf02af4e6@mail.gmail.com>
	 <20060106141509.01c66bf2.tihirvon@gmail.com>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 13:20:12 +0100
Message-Id: <1136550013.2940.32.camel@laptopd505.fenrus.org>
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

On Fri, 2006-01-06 at 14:15 +0200, Timo Hirvonen wrote:
> On Fri, 6 Jan 2006 13:51:41 +0200
> Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> 
> > On 1/5/06, Timo Hirvonen <tihirvon@gmail.com> wrote:
> > > All kstrdup() callers use GFP_KERNEL flag so this parameter seems to be
> > > useless.
> > 
> > Please don't. You're making the API inconsistent and forcing everyone
> > to use GFP_KERNEL for little or no benefit.
> 
> I don't see why any other GFP_* flag could be useful for strings.

I think you missed the point a bit..
the GFP_ flags aren't so much about what you allocate it, but in what
circumstances you are allocating (eg inside a lock/irq or not etc)



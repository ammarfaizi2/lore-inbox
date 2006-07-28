Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161279AbWG1U1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279AbWG1U1a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161284AbWG1U1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:27:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60844 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161279AbWG1U13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:27:29 -0400
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       alokk@calsoftinc.com
In-Reply-To: <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com>
References: <1154044607.27297.101.camel@localhost.localdomain>
	 <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
	 <1154067247.27297.104.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com>
	 <1154117501.10196.2.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 28 Jul 2006 22:27:21 +0200
Message-Id: <1154118441.6416.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 13:18 -0700, Christoph Lameter wrote:
> On Fri, 28 Jul 2006, Thomas Gleixner wrote:
> 
> > On Fri, 2006-07-28 at 08:35 -0700, Christoph Lameter wrote:
> > > On Fri, 28 Jul 2006, Thomas Gleixner wrote:
> > > 
> > > > If you need more info, I can add debugs. It happens every bootup.
> > > 
> > > Could you tell me why _spin_lock and _spin_unlock seem 
> > > to be calling into the slab allocator? Also what is child_rip()? Cannot 
> > > find that function upstream.
> > 
> > arch/x86_64/kernel/entry.S
> 
> Ah. Ok wrong arch. Why does _spin_unlock_irq call child_rip and then end 
> up in the slab allocator?
> 
> Why does _spin_lock call kmem_cache_free?
> 
> Is the stack trace an accurate representation of the calling sequence?

no
not unless the person reporting it has set the various kernel debugging
options, it's only a guestimate with noise in.

> 
> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWJJTiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWJJTiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWJJTiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:38:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30664 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030227AbWJJTit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:38:49 -0400
Subject: Re: 2.6.18 suspend regression on Intel Macs
From: Arjan van de Ven <arjan@infradead.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
In-Reply-To: <1160507296.5134.4.camel@funkylaptop>
References: <1160417982.5142.45.camel@funkylaptop>
	 <20061010103910.GD31598@elf.ucw.cz>
	 <1160476889.3000.282.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org>
	 <1160507296.5134.4.camel@funkylaptop>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Tue, 10 Oct 2006 21:38:41 +0200
Message-Id: <1160509121.3000.327.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 21:08 +0200, Frédéric Riss wrote:
> Le mardi 10 octobre 2006 à 08:33 -0700, Linus Torvalds a écrit :
> > > If we do this we probably should at least key this of some DMI
> > > identification for the mac mini..
> > 
> > No. That would be silly.
> > 
> > Having _conditional_ code is not only bigger, it's orders of magnitude 
> > more complex and likely to break. It's much better to say: "We know at 
> > least one machine needs this" than it is to say "We know machine X needs 
> > this", because the latter has extra complexity that just doesn't buy you 
> > anything.
> > 
> > It's much better to treat everybody the same, if that works. That way, you 
> > don't have different code-paths.
> 
> So what's the plan? Should/Will the ACPI guys remove the bit-preserving
> change brought in with the latest ACPICA merge?


it sounds like a good idea to at least put the workaround back for now,
until a more elegant solution (maybe something can be done to make it
not needed anymore) is found...
(or until it shows it breaks other machines at which point
reconsideration is also needed)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUGNXjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUGNXjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUGNXjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:39:23 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33249 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S265119AbUGNXjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:39:22 -0400
Date: Wed, 14 Jul 2004 16:39:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Eger <eger@havoc.gtf.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pmac_zilog: initialize port spinlock on all init paths
Message-ID: <20040714233920.GP21856@smtp.west.cox.net>
References: <20040712075113.GB19875@havoc.gtf.org> <20040712082104.GA22366@havoc.gtf.org> <20040712220935.GA20049@havoc.gtf.org> <20040713003935.GA1050@havoc.gtf.org> <1089692194.1845.38.camel@gaston> <20040714040403.GA29729@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714040403.GA29729@havoc.gtf.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 12:04:03AM -0400, David Eger wrote:

[snip]
> > > ( of course, it still spews diahrea of 'IN from bad port XXXXXXXX'
> > >   but then, I don't have the hardware.... still, seems weird that OF
> > >   would report that I do have said hardware :-/ )
> > 
> > The IN from bad port is a different issue, it's probably issued by
> > another driver trying to tap legacy hardware, either serial.o or
> > ps/2 kbd, I suppose, check what else of that sort you have in your
> >  .config
> 
> Sure enough, the "IN from bad port XXXXXXXX" ended up being the i8042
> serial PC keyboard driver, enabled with CONFIG_SERIO_I8042.  Don't know
> why that's in ppc defconfig....

That's on for all of the ppc boards with an i8042 which the defconfig is
supposed to support (prep & chrp hardware).

-- 
Tom Rini
http://gate.crashing.org/~trini/

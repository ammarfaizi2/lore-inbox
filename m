Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVCIHbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVCIHbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 02:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVCIHbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 02:31:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:16058 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262100AbVCIHaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 02:30:01 -0500
Subject: Re: PCMCIA product id strings -> hashes generation at compilation
	time? [Was: Re: [patch 14/38] pcmcia: id_table for wavelan_cs]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       jt@hpl.hp.com, linux-pcmcia@lists.infradead.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309060004.GE17287@kroah.com>
References: <20050308123426.249fa934.akpm@osdl.org>
	 <20050227161308.GO7351@dominikbrodowski.de>
	 <20050307225355.GB30371@bougret.hpl.hp.com>
	 <20050307230102.GA29779@isilmar.linta.de>
	 <20050307150957.0456dd75.akpm@osdl.org>
	 <20050307232339.GA30057@isilmar.linta.de>
	 <20050308191138.GA16169@isilmar.linta.de>
	 <Pine.LNX.4.58.0503081438040.13251@ppc970.osdl.org>
	 <20050308231636.GA20658@isilmar.linta.de>
	 <1110347109.32524.56.camel@gaston>  <20050309060004.GE17287@kroah.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 18:21:08 +1100
Message-Id: <1110352868.32525.65.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > The difficulty is that extracting and evaluating them breaks the wonderful 
> > > bus-independent MODNAME implementation for hotplug suggested by Roman Kagan
> > > ( http://article.gmane.org/gmane.linux.hotplug.devel/7039 ), and that these
> > > strings may contain spaces and other "strange" characters. The latter may be 
> > > worked around, but the former cannot. /etc/hotplug/pcmcia.agent looks really
> > > clean because of this MODNAME implementation:
> > 
> > Same goes with Open Firmware match strings that we are about to pass
> > down to userspace as well. Hotplug will have to learn to deal with
> > those.
> 
> Ok, any suggestions that don't involve hashes?

Not sure, I haven't looked at the details & issues involves (I just
"spotted" the issue about space while quick-reading lkml). I suppose
quotes around the strings are good enough, at least for OF, I yet have
to see a "compatible", "name" or "type" property with quotes in it...

Ben.



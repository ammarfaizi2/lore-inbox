Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272600AbTG1AOu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270991AbTG1AG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:06:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44680
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270539AbTG0Xtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:49:49 -0400
Subject: Re: [PATCH] Remove module reference counting.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030727214701.A23137@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org>
	 <20030727193919.832302C450@lists.samba.org>
	 <20030727214701.A23137@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059350466.14759.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jul 2003 01:01:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-27 at 22:47, Arjan van de Ven wrote:
> On Mon, Jul 28, 2003 at 05:34:36AM +1000, Rusty Russell wrote:
> > 
> > The kudzu one and Alan's USB firmware example bother me more: they
> > load then unload modules currently? 
> 
> I'm pretty sure kudzu doesn't

Redid the instrumentation - kudzu loads a *lot* of modules which do a 
ton of stuff then decide they failed to initialize. It doesn't seem
to load modules that initialize successfully then unload then. Those
stay in memory by default.



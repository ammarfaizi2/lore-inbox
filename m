Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272049AbTG2UXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272058AbTG2UXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:23:10 -0400
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:8325
	"EHLO gaston") by vger.kernel.org with ESMTP id S272049AbTG2UXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:23:07 -0400
Subject: Re: [PATCH] Framebuffer: client notification mecanism & PM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307291753530.5874-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0307291753530.5874-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059510171.8538.53.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 16:22:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-29 at 12:55, James Simmons wrote:
> > > matroxfb tried to use a 'dead' for handling hot removal, but your code
> > > looks definitely saner
> > 
> > My code wasn't really intended to deal with hot-removal, more with
> > "what happens if printk occurs during the Power Management suspend
> > sequence", but I tried to keep the notification mecanism simple
> > enough so it could be used for that as well. Also, indeed, the fbcon
> > changes should deal with hot-removal in some way (though you surely
> > also want to "deatch" from the fbdev's in this case).
> > 
> > Among other things that could be used for is live monitor insertion/
> > removal detection (some HW are able to do that), "pivot" monitor
> > kind of things, etc... typically via the mode_changed hook.
> 
> I knew it was a matter of time before "client" management would happen. 
> Is this a 2.6.X thing tho or shoudl we wait for the next developement 
> cycle. I don't mind working on experimental stuff.

We need that now for proper power management.

Ben.


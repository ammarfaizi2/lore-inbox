Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTGIRgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbTGIRgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:36:05 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:34031 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264340AbTGIRf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:35:58 -0400
Subject: Re: [Linux-fbdev-devel] fbdev and power management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307091844220.19058-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0307091844220.19058-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057772998.15932.55.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 09 Jul 2003 19:49:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-09 at 19:45, James Simmons wrote:
> > My concern is that there has been:
> > - 4 months of non-exposure of this work
> > - 4 months of making the current system work
> > - and putting it in will require a fair number of drivers to be 
> >   re-worked.
> > 
> > Apart from driver re-work and that the core interfaces are supposed to
> > be stable, what are the technical arguments against merging it, say,
> > today?
> 
> This is the reason I have waited. 

Those changes will only affect drivers, there is still need for
some mecanism to deal with fbcon. I'll send you a patch before the
end of the week hopefully. There may be a better way of doing it
than my patch by having fbcon be someway a child of the HW driver
in the device-tree, but it's a bit nasty right now, and my patch
adds a more generic way to notify "clients" of fbdev's (like fbcon)
of events at the low level that could be used for hotplug monitor
change notification or whatever...

Ben



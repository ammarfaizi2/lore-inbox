Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWIYV0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWIYV0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWIYV0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:26:24 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:40332 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751401AbWIYV0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:26:23 -0400
Subject: Re: [PATCH -mm] console: console_drivers not initialized
From: Daniel Walker <dwalker@mvista.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060925211122.GC25257@flint.arm.linux.org.uk>
References: <20060925210710.931336000@mvista.com>
	 <20060925211122.GC25257@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 14:26:21 -0700
Message-Id: <1159219581.3648.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 22:11 +0100, Russell King wrote:
> On Mon, Sep 25, 2006 at 02:07:10PM -0700, dwalker@mvista.com wrote:
> > I was doing -rt stuff on a PPC PowerBook G4. It would always reboot
> > itself when it hit console_init() .
> > 
> > I noticed that the console code seems to want console_drivers = NULL,
> > but it never actually sets it that way. Once I added this, the reboot 
> > issue was gone..
> 
> It's a BSS variable, it _should_ be zeroed by the architecture's BSS
> initialisation.  If not, it suggests there's something very _very_
> wrong in the architecture's C runtime initialisation code.
> 
> As such, this patch is merely a band-aid, not a correct fix.

It happens on two different compilers gcc 4.1 and 3.3 .. I was using
arch/powerpc/ which is fairly new .. However, If stuff was suppose to be
zero'd and wasn't, I'd imagine this machine would be rebooting _a lot_
more often.

Daniel


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTLDSki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTLDSki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:40:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30726 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262283AbTLDSkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:40:36 -0500
Date: Thu, 4 Dec 2003 18:40:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Worst recursion in the kernel
Message-ID: <20031204184032.D31675@flint.arm.linux.org.uk>
Mail-Followup-To: J?rn Engel <joern@wohnheim.fh-wedel.de>,
	David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
References: <20031203143122.GA6470@wohnheim.fh-wedel.de> <20031203100709.B6625@sonic.net> <20031203190440.GA15857@wohnheim.fh-wedel.de> <20031203225743.A25889@flint.arm.linux.org.uk> <20031204150846.GJ1117@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031204150846.GJ1117@admingilde.org>; from tali@admingilde.org on Thu, Dec 04, 2003 at 04:08:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 04:08:46PM +0100, Martin Waitz wrote:
> hi :)
> 
> On Wed, Dec 03, 2003 at 10:57:43PM +0000, Russell King wrote:
> > Yes, but the condition of the /data/ is such that it will not recurse.
> > 
> > A pure "can this function call that function" analysis ignoring the
> > state of the data will say this will infinitely recuse.  Include
> > the data, and you'll find it has a very definite recursion limit.
> 
> but it makes sense to restrucure the code to make it more
> readable/understandable even if it can be proven that the code is
> correct

Oddly that's what I have been doing, but we've run out of time to
completely eliminate the recursions in PCMCIA before the 2.6 brakes
were turned on.  Sure, if someone wants to try submitting a PCMCIA
rewrite to Linus right now and wants to receive Linus' flames, go
ahead. 8)

So, for the time being, live with the fact that current automated
program analysis detects the recusion.  Inteligent human examination
will tell you that it can't infinitely recurse.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

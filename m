Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTDHWU2 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbTDHWUO (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:20:14 -0400
Received: from palrel10.hp.com ([156.153.255.245]:54503 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262190AbTDHWTg (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:19:36 -0400
Date: Tue, 8 Apr 2003 15:31:11 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHES 2.5.67] PCMCIA hotplugging, in-kernel-matching and depmod support
Message-ID: <20030408223111.GA25785@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote :
> On Tue, Apr 08, 2003 at 10:56:23PM +0200, Dominik Brodowski wrote:
> > ... and the deprecation of "cardmgr" and "cardctl"
> > 
> > Dear kernel developers and testers,
> > 
> > Updated and re-diffed revisions of my pcmcia-related patches are 
> > available at http://www.brodo.de/pcmcia/
> > 
> > These patches update the PCMCIA subsystem (16-bit) to use the driver
> > model matching and hotplug utilities. The "cardmgr" will not be 
> > needed any longer - in fact, it won't even work any longer.
> > 
> > They are based on kernel 2.5.67
> 
> Will we see pcmcia id lists making their way into low-level drivers?
> 
> That was a big stumbling block when I last looked at the "big picture"
> for pcmcia -- in-kernel drivers still required probe assistance from
> userspace via the /etc/pcmcia/* bindings.

	No ! Please don't do that, it will only bring madness.

	Example :
	Lucent/Agere Orinoco wireless card :
		manfid 0x0156,0x0002
		possible drivers : wlan_cs ; orinoco_cs
	Intersil PrismII and clones (Linksys, ...) :
		manfid 0x0156,0x0002
		possible drivers : prism2_cs ; hostap_cs

	Please explain me in details how your stuff will cope with the
above, and how to make sure the right driver is loaded in every case
and how user can control this.
	If your scheme can't cope with the simple real life example
above (I've got those cards on my desk, and those drivers on my disk),
then it's no good to me.

	Good luck...

	Jean

